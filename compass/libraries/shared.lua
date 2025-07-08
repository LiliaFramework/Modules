mCompass_Settings = {}
mCompass_Settings.Compass_Enabled = true
mCompass_Settings.Force_Server_Style = false
mCompass_Settings.Use_FastDL = true
mCompass_Settings.Style_Selected = "squad"
mCompass_Settings.Allow_Player_Spotting = true
mCompass_Settings.Allow_Entity_Spotting = false
mCompass_Settings.Max_Spot_Distance = 15748.03
mCompass_Settings.Spot_Duration = 10
mCompass_Settings.Spotted_Enemy_Color = Color(255, 0, 0)
mCompass_Settings.Styles = {
    ["fortnite"] = {
        heading = true,
        compassX = 0.5,
        compassY = 0.05,
        width = 0.25,
        height = 0.03,
        spacing = 2.5,
        ratio = 2,
        offset = 0,
        maxMarkerSize = 1,
        minMarkerSize = 0.5,
        color = Color(255, 255, 255)
    },
    ["squad"] = {
        heading = true,
        compassX = 0.5,
        compassY = 0.9,
        width = 0.25,
        height = 0.03,
        spacing = 2,
        ratio = 1.8,
        offset = 0,
        maxMarkerSize = 1,
        minMarkerSize = 0.5,
        color = Color(255, 255, 255)
    },
    ["pubg"] = {
        heading = true,
        compassX = 0.5,
        compassY = 0.05,
        width = 0.25,
        height = 0.03,
        spacing = 2.5,
        ratio = 1.8,
        offset = 0,
        maxMarkerSize = 1,
        minMarkerSize = 0.5,
        color = Color(255, 255, 255)
    }
}

if SERVER then
    util.AddNetworkString("mCompass_AddMarker")
    util.AddNetworkString("mCompass_RemoveMarker")
    local mCompass_MarkerTable = mCompass_MarkerTable or {}
    function mCompass_AddMarker(ply, pos, players, time, color, icon, name)
        name = name or ""
        icon = icon or ""
        color = color or mCompass_Settings.Spotted_Enemy_Color
        players = players or ply and ply:IsPlayer() and team.GetPlayers(ply:Team())
        local id = #mCompass_MarkerTable + 1
        if players then
            for _, v in pairs(players) do
                net.Start("mCompass_AddMarker")
                net.WriteInt(id, 4)
                net.WriteBool(false)
                net.WriteVector(pos)
                net.WriteFloat(time)
                net.WriteColor(color)
                net.WriteString(icon)
                net.WriteString(name)
                net.Send(v)
            end
        else
            net.Start("mCompass_AddMarker")
            net.WriteInt(id, 4)
            net.WriteBool(false)
            net.WriteVector(pos)
            net.WriteFloat(time)
            net.WriteColor(color)
            net.WriteString(icon)
            net.WriteString(name)
            net.Broadcast()
        end

        table.insert(mCompass_MarkerTable, {id, pos, time, color, icon, name})
        return id
    end

    function mCompass_AddEntityMarker(ply, ent, players, time, color, icon, name)
        name = name or ""
        icon = icon or ""
        color = color or mCompass_Settings.Spotted_Enemy_Color
        players = players or ply and ply:IsPlayer() and team.GetPlayers(ply:Team())
        local id = #mCompass_MarkerTable + 1
        if players then
            for _, v in pairs(players) do
                net.Start("mCompass_AddMarker")
                net.WriteInt(id, 4)
                net.WriteBool(true)
                net.WriteEntity(ent)
                net.WriteFloat(time)
                net.WriteColor(color)
                net.WriteString(icon)
                net.WriteString(name)
                net.Send(v)
            end
        else
            net.Start("mCompass_AddMarker")
            net.WriteInt(id, 4)
            net.WriteBool(true)
            net.WriteEntity(ent)
            net.WriteFloat(time)
            net.WriteColor(color)
            net.WriteString(icon)
            net.WriteString(name)
            net.Broadcast()
        end

        table.insert(mCompass_MarkerTable, {id, pos, time, color, icon, name})
        return id
    end

    function Adv_Compass_RemoveMarker(markerID)
        for k, v in pairs(mCompass_MarkerTable) do
            if markerID == v[1] then
                net.Start("mCompass_RemoveMarker")
                net.WriteInt(markerID, 4)
                net.Broadcast()
                table.remove(mCompass_MarkerTable, k)
            end
        end
    end

    if mCompass_Settings.Use_FastDL then
        resource.AddFile("materials/compass/compass_marker_01.vmt")
        resource.AddFile("materials/compass/compass_marker_02.vmt")
        resource.AddFile("resource/fonts/exo/Exo-Regular.ttf")
    end

    local function v(arg)
        arg = tonumber(arg)
        return math.Clamp(arg or 255, 0, 255)
    end

    concommand.Add("mcompass_spot", function(ply, _, args)
        if not mCompass_Settings.Allow_Player_Spotting then return end
        local color = string.ToColor(v(args[1]) .. " " .. v(args[2]) .. " " .. v(args[3]) .. " " .. v(args[4]))
        local tr = util.TraceLine({
            start = ply:EyePos(),
            endpos = ply:EyePos() + ply:EyeAngles():Forward() * mCompass_Settings.Max_Spot_Distance,
            filter = ply
        })

        local t = CurTime() + mCompass_Settings.Spot_Duration
        if tr.Entity and not tr.HitWorld then
            mCompass_AddEntityMarker(ply, tr.Entity, nil, t, color)
        else
            mCompass_AddMarker(ply, tr.HitPos, nil, t, color)
        end
    end)
else
    concommand.Add("mcompass_reset", function()
        RunConsoleCommand("mcompass_enabled", "1")
        RunConsoleCommand("mcompass_style", "1")
        RunConsoleCommand("mcompass_heading", "1")
        RunConsoleCommand("mcompass_xposition", "0.5")
        RunConsoleCommand("mcompass_yposition", "0.05")
        RunConsoleCommand("mcompass_width", "0.25")
        RunConsoleCommand("mcompass_height", "0.03")
        RunConsoleCommand("mcompass_spacing", "2.5")
        RunConsoleCommand("mcompass_ratio", "1.8")
        RunConsoleCommand("mcompass_color", "255", "255", "255", "255")
    end)

    local cl_cvar_mcompass_enabled, cl_cvar_mcompass_style, cl_cvar_mcompass_heading
    local cl_cvar_mcompass_xposition, cl_cvar_mcompass_yposition, cl_cvar_mcompass_width, cl_cvar_mcompass_height
    local cl_cvar_mcompass_spacing, cl_cvar_mcompass_ratio, cl_cvar_mcompass_color
    local function loadFonts()
        hook.Call("mCompass_loadFonts")
    end

    local cl_style_selected_str, compass_style
    local function updateCompassSettings()
        cl_style_selected_str = cl_cvar_mcompass_style == 1 and "fortnite" or cl_cvar_mcompass_style == 2 and "squad" or "pubg"
        compass_style = mCompass_Settings.Force_Server_Style and mCompass_Settings.Styles[mCompass_Settings.Style_Selected] or {
            style = cl_style_selected_str,
            heading = cl_cvar_mcompass_heading,
            compassX = cl_cvar_mcompass_xposition,
            compassY = cl_cvar_mcompass_yposition,
            width = cl_cvar_mcompass_width,
            height = cl_cvar_mcompass_height,
            spacing = cl_cvar_mcompass_spacing,
            ratio = cl_cvar_mcompass_ratio,
            offset = mCompass_Settings.Styles[cl_style_selected_str].offset,
            color = cl_cvar_mcompass_color,
            maxMarkerSize = 1,
            minMarkerSize = 0.5
        }

        if mCompass_Settings.Force_Server_Style then compass_style.style = mCompass_Settings.Style_Selected end
        loadFonts()
    end

    local function v(arg)
        arg = tonumber(arg)
        return math.Clamp(arg or 255, 0, 255)
    end

    CreateClientConVar("mcompass_enabled", "1", true, false)
    cvars.AddChangeCallback("mcompass_enabled", function(_, _, newValue)
        if newValue == "1" or newValue == "0" then cl_cvar_mcompass_enabled = tobool(newValue) end
        updateCompassSettings()
    end, "mcompass_enabled_cvar_callback")

    cl_cvar_mcompass_enabled = tobool(GetConVar("mcompass_enabled"):GetInt())
    CreateClientConVar("mcompass_style", "1", true, false)
    cvars.AddChangeCallback("mcompass_style", function(_, _, newValue)
        if newValue == "1" or newValue == "2" or newValue == "3" then cl_cvar_mcompass_style = tonumber(newValue) end
        updateCompassSettings()
    end, "mcompass_style_cvar_callback")

    cl_cvar_mcompass_style = GetConVar("mcompass_style"):GetInt()
    CreateClientConVar("mcompass_heading", "1", true, false)
    cvars.AddChangeCallback("mcompass_heading", function(_, _, newValue)
        if newValue == "1" or newValue == "0" then cl_cvar_mcompass_heading = tobool(newValue) end
        updateCompassSettings()
    end, "mcompass_heading_cvar_callback")

    cl_cvar_mcompass_heading = tobool(GetConVar("mcompass_heading"):GetInt())
    CreateClientConVar("mcompass_xposition", "0.5", true, false)
    cvars.AddChangeCallback("mcompass_xposition", function(_, _, newValue)
        local foo = tonumber(newValue)
        if foo and foo >= 0 and foo <= 1 then cl_cvar_mcompass_xposition = foo end
        updateCompassSettings()
    end, "mcompass_xposition_cvar_callback")

    cl_cvar_mcompass_xposition = GetConVar("mcompass_xposition"):GetFloat()
    CreateClientConVar("mcompass_yposition", "0.05", true, false)
    cvars.AddChangeCallback("mcompass_yposition", function(_, _, newValue)
        local foo = tonumber(newValue)
        if foo and foo >= 0 and foo <= 1 then cl_cvar_mcompass_yposition = foo end
        updateCompassSettings()
    end, "mcompass_yposition_cvar_callback")

    cl_cvar_mcompass_yposition = GetConVar("mcompass_yposition"):GetFloat()
    CreateClientConVar("mcompass_width", "0.25", true, false)
    cvars.AddChangeCallback("mcompass_width", function(_, _, newValue)
        local foo = tonumber(newValue)
        if foo and foo >= 0 and foo <= 1 then cl_cvar_mcompass_width = foo end
        updateCompassSettings()
    end, "mcompass_width_cvar_callback")

    cl_cvar_mcompass_width = GetConVar("mcompass_width"):GetFloat()
    CreateClientConVar("mcompass_height", "0.03", true, false)
    cvars.AddChangeCallback("mcompass_height", function(_, _, newValue)
        local foo = tonumber(newValue)
        if foo and foo >= 0 and foo <= 1 then cl_cvar_mcompass_height = foo end
        updateCompassSettings()
    end, "mcompass_height_cvar_callback")

    cl_cvar_mcompass_height = GetConVar("mcompass_height"):GetFloat()
    CreateClientConVar("mcompass_spacing", "2.5", true, false)
    cvars.AddChangeCallback("mcompass_spacing", function(_, _, newValue)
        local foo = tonumber(newValue)
        if foo and foo > 1 and foo < 10 then cl_cvar_mcompass_spacing = foo end
        updateCompassSettings()
    end, "mcompass_spacing_cvar_callback")

    cl_cvar_mcompass_spacing = GetConVar("mcompass_spacing"):GetFloat()
    CreateClientConVar("mcompass_ratio", "1.8", true, false)
    cvars.AddChangeCallback("mcompass_ratio", function(_, _, newValue)
        local foo = tonumber(newValue)
        if foo and foo > 0 and foo < 10 then cl_cvar_mcompass_ratio = foo end
        updateCompassSettings()
    end, "mcompass_ratio_cvar_callback")

    cl_cvar_mcompass_ratio = GetConVar("mcompass_ratio"):GetFloat()
    CreateClientConVar("mcompass_color", "255 255 255 255", true, false)
    cvars.AddChangeCallback("mcompass_color", function(_, _, newValue)
        local args = string.Explode(" ", newValue)
        cl_cvar_mcompass_color = string.ToColor(v(args[1]) .. " " .. v(args[2]) .. " " .. v(args[3]) .. " " .. v(args[4]))
        updateCompassSettings()
    end, "mcompass_color_cvar_callback")

    do
        local foo = string.Explode(" ", GetConVar("mcompass_color"):GetString())
        cl_cvar_mcompass_color = string.ToColor(v(foo[1]) .. " " .. v(foo[2]) .. " " .. v(foo[3]) .. " " .. v(foo[4]))
    end

    displayDistanceFontTable = displayDistanceFontTable or {}
    local function markerScaleFunc(markerSizeScale)
        local n = math.Round(markerSizeScale)
        if not oldMarkerSizeScale or oldMarkerSizeScale ~= n then
            if displayDistanceFontTable[n] then return displayDistanceFontTable[n].name end
            local newFontName = "exo_compass_DDN_" .. n
            displayDistanceFontTable[n] = {
                name = newFontName,
                size = n
            }

            surface.CreateFont(newFontName, {
                font = "Exo",
                size = n,
                antialias = true
            })

            oldMarkerSizeScale = n
            return newFontName
        end
        return displayDistanceFontTable[oldMarkerSizeScale].name
    end

    fontRatioChangeTable = fontRatioChangeTable or {}
    hook.Add("mCompass_loadFonts", "mCompass_loadFonts_addon", function()
        local h = compass_style.height
        local r = compass_style.ratio
        if r ~= mCompass_oldFontRatio then
            for _, v in pairs(fontRatioChangeTable) do
                if "exo_compass_Numbers_" .. r == v.numberName then
                    mCompass_oldFontRatio = r
                    return v
                end
            end

            surface.CreateFont("exo_compass_Numbers_" .. r, {
                font = "Exo",
                size = math.Round(ScrH() * h / r),
                antialias = true
            })

            surface.CreateFont("exo_compass_Distance-Display-Numbers_" .. r, {
                font = "Exo",
                size = ScrH() * h / r * compass_style.maxMarkerSize,
                antialias = true
            })

            surface.CreateFont("exo_compass_Letters", {
                font = "Exo",
                size = ScrH() * h,
                antialias = true
            })

            table.insert(fontRatioChangeTable, {
                ratio = r,
                numberName = "exo_compass_Numbers_" .. r
            })

            mCompass_oldFontRatio = r
        end
    end)

    updateCompassSettings()
    local cl_mCompass_MarkerTable = cl_mCompass_MarkerTable or {}
    local mat = Material("compass/compass_marker_01")
    local mat2 = Material("compass/compass_marker_02")
    net.Receive("mCompass_AddMarker", function()
        local id = net.ReadInt(4)
        local isEntity = net.ReadBool()
        local pos = not isEntity and net.ReadVector() or nil
        local ent = isEntity and net.ReadEntity() or nil
        local time = net.ReadFloat()
        local color = net.ReadColor()
        local icon_mat = net.ReadString()
        local icon_name = net.ReadString()
        icon_mat = icon_mat == "" and mat or Material(icon_mat)
        icon_name = icon_name or ""
        table.insert(cl_mCompass_MarkerTable, {isEntity, pos or ent or nil, time, color, id, icon_mat, icon_name})
    end)

    net.Receive("mCompass_RemoveMarker", function()
        local id = net.ReadInt(4)
        for k, v in pairs(cl_mCompass_MarkerTable) do
            if id == v[5] then table.remove(cl_mCompass_MarkerTable, k) end
        end
    end)

    local function getMetricValue(units)
        local meters = math.Round(units * 0.01905)
        local kilometers = math.Round(meters / 1000, 2)
        return kilometers > 1 and kilometers .. "km" or meters .. "m"
    end

    local function getTextSize(font, text)
        surface.SetFont(font)
        return surface.GetTextSize(text)
    end

    local function custom_compass_DrawLineFunc(mask1, mask2, line, color)
        render.ClearStencil()
        render.SetStencilEnable(true)
        render.SetStencilFailOperation(STENCILOPERATION_KEEP)
        render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
        render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
        render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
        render.SetStencilWriteMask(1)
        render.SetStencilReferenceValue(1)
        surface.SetDrawColor(Color(0, 0, 0, 1))
        surface.DrawRect(mask1[1], mask1[2], mask1[3], mask1[4])
        surface.DrawRect(mask2[1], mask2[2], mask2[3], mask2[4])
        render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
        render.SetStencilTestMask(1)
        surface.SetDrawColor(color)
        surface.DrawLine(line[1], line[2], line[3], line[4])
        render.SetStencilEnable(false)
    end

    local adv_compass_tbl = {
        [0] = "N",
        [45] = "NE",
        [90] = "E",
        [135] = "SE",
        [180] = "S",
        [225] = "SW",
        [270] = "W",
        [315] = "NW",
        [360] = "N"
    }

    hook.Add("HUDPaint", "HUDPaint_Compass", function()
        local ply = LocalPlayer()
        if not (mCompass_Settings.Compass_Enabled and cl_cvar_mcompass_enabled) then return end
        local ang = ply:GetAngles()
        local compassX = ScrW() * compass_style.compassX
        local compassY = ScrH() * compass_style.compassY
        local width = ScrW() * compass_style.width
        local height = ScrH() * compass_style.height
        local cl_spacing = compass_style.spacing
        local ratio = compass_style.ratio
        local color = compass_style.color
        local minMarkerSize = ScrH() * compass_style.minMarkerSize / 45
        local maxMarkerSize = ScrH() * compass_style.maxMarkerSize / 45
        local heading = compass_style.heading
        local offset = compass_style.offset
        spacing = width * cl_spacing / 360
        numOfLines = width / spacing
        fadeDistMultiplier = 1
        fadeDistance = width / 2 / fadeDistMultiplier
        surface.SetFont("exo_compass_Numbers_" .. ratio)
        if compass_style.style == "squad" then
            local text = math.Round(360 - (ang.y - offset) % 360)
            local font = "exo_compass_Numbers_" .. ratio
            local compassBearingTextW = select(1, getTextSize(font, text))
            surface.SetTextColor(Color(255, 255, 255))
            surface.SetTextPos(compassX - compassBearingTextW / 2, compassY)
            surface.DrawText(text)
        end

        for i = math.Round(-ang.y) % 360, math.Round(-ang.y) % 360 + numOfLines do
            local x = compassX - width / 2 + (i + ang.y) % 360 * spacing
            local value = math.abs(x - compassX)
            local calc = 1 - (value + value - fadeDistance) / (width / 2)
            local calculation = 255 * math.Clamp(calc, 0.001, 1)
            local i_offset = -math.Round(i - offset - numOfLines / 2) % 360
            if i_offset % 15 == 0 and i_offset >= 0 then
                local a = i_offset
                local text = adv_compass_tbl[360 - a % 360] or 360 - a % 360
                local isString = type(text) == "string"
                local font = isString and "exo_compass_Letters" or "exo_compass_Numbers_" .. ratio
                local w = select(1, getTextSize(font, text))
                surface.SetDrawColor(Color(color.r, color.g, color.b, calculation))
                surface.SetTextColor(Color(color.r, color.g, color.b, calculation))
                surface.SetFont(font)
                if compass_style.style == "pubg" then
                    surface.DrawLine(x, compassY, x, compassY + height * 0.2)
                    surface.DrawLine(x, compassY, x, compassY + height * 0.5)
                    surface.SetTextPos(x - w / 2, compassY + height * 0.6)
                    surface.DrawText(text)
                elseif compass_style.style == "fortnite" then
                    if not isString then
                        surface.DrawLine(x, compassY, x, compassY + height * 0.2)
                        surface.DrawLine(x, compassY, x, compassY + height * 0.3)
                        surface.SetTextPos(x - w / 2, compassY + height * 0.5)
                        surface.DrawText(text)
                    else
                        surface.SetTextPos(x - w / 2, compassY)
                        surface.DrawText(text)
                    end
                elseif compass_style.style == "squad" then
                    local compassBearingTextW = select(1, getTextSize("exo_compass_Numbers_" .. ratio, "000"))
                    local mask1 = {compassX - width / 2 - fadeDistance, compassY, width / 2 + fadeDistance - compassBearingTextW / 1.5, height * 2}
                    local mask2 = {compassX + compassBearingTextW / 1.5, compassY, width / 2 + fadeDistance - compassBearingTextW / 1.5, height * 2}
                    local col = Color(color.r, color.g, color.b, calculation)
                    local line = {x, compassY, x, compassY + height * 0.5}
                    custom_compass_DrawLineFunc(mask1, mask2, line, col)
                    surface.SetTextPos(x - w / 2, compassY + height * 0.55)
                    surface.DrawText(text)
                end
            end

            if compass_style.style == "squad" and i_offset % 5 == 0 and i_offset % 15 ~= 0 then
                local compassBearingTextW = select(1, getTextSize("exo_compass_Numbers_" .. ratio, "000"))
                local mask1 = {compassX - width / 2 - fadeDistance, compassY, width / 2 + fadeDistance - compassBearingTextW / 1.5, height}
                local mask2 = {compassX + compassBearingTextW / 1.5, compassY, width / 2 + fadeDistance - compassBearingTextW / 1.5, height}
                local col = Color(color.r, color.g, color.b, calculation)
                local line = {x, compassY, x, compassY + height * 0.25}
                custom_compass_DrawLineFunc(mask1, mask2, line, col)
            end
        end

        for k, v in pairs(cl_mCompass_MarkerTable) do
            if CurTime() > v[3] or v[1] and not IsValid(v[2]) then
                table.remove(cl_mCompass_MarkerTable, k)
            else
                local spotPos = v[1] and v[2]:GetPos() or v[2]
                local d = ply:GetPos():Distance(spotPos)
                local currentVar = 1 - d / (300 / 0.01905)
                local markerScale = Lerp(currentVar, minMarkerSize, maxMarkerSize)
                local font = markerScaleFunc(markerScale)
                local yAng = ang.y - (spotPos - ply:GetPos()):GetNormalized():Angle().y
                local markerSpot = math.Clamp((compassX + width / 2 * cl_spacing) - (-yAng - offset - 180) % 360 * spacing, compassX - width / 2, compassX + width / 2)
                surface.SetMaterial(v[6])
                surface.SetDrawColor(v[4])
                surface.DrawTexturedRect(markerSpot - markerScale / 2, compassY - markerScale - markerScale / 2, markerScale, markerScale)
                local text = v[7] ~= "" and v[7] .. " - " .. getMetricValue(d) or getMetricValue(d)
                local w = select(1, getTextSize(font, text))
                surface.SetFont(font)
                surface.SetTextColor(Color(255, 255, 255))
                surface.SetTextPos(markerSpot - w / 2, compassY - markerScale - markerScale / 2 - select(2, getTextSize(font, text)))
                surface.DrawText(text)
            end
        end

        if compass_style.heading and compass_style.style ~= "squad" then
            local triangleSize = 8
            local triangleHeight = compassY
            local triangle = {
                {
                    x = compassX - triangleSize / 2,
                    y = triangleHeight - triangleSize * 2
                },
                {
                    x = compassX + triangleSize / 2,
                    y = triangleHeight - triangleSize * 2
                },
                {
                    x = compassX,
                    y = triangleHeight - triangleSize
                }
            }

            surface.SetDrawColor(255, 255, 255)
            draw.NoTexture()
            surface.DrawPoly(triangle)
            if heading then
                local text = math.Round(-ang.y - offset) % 360
                local font = "exo_compass_Numbers_" .. ratio
                local w = select(1, getTextSize(font, text))
                surface.SetFont(font)
                surface.SetTextColor(Color(255, 255, 255))
                surface.SetTextPos(compassX - w / 2, compassY - select(2, getTextSize(font, text)) - triangleSize * 2)
                surface.DrawText(text)
            end
        end
    end)

    hook.Add("PopulateToolMenu", "mCompass_PopulateToolMenu", function()
        spawnmenu.AddToolMenuOption("Options", "mCompass", "Settings", "Settings", "", "", function(panel)
            panel:ClearControls()
            local Label1 = vgui.Create("DLabel", panel)
            Label1:Dock(TOP)
            Label1:SetTextColor(Color(50, 50, 50))
            Label1:SetText("Client Settings")
            Label1:SizeToContents()
            panel:AddItem(Label1)
            local box = vgui.Create("DCheckBoxLabel", panel)
            box:SetText("Enabled")
            box:SetTextColor(Color(50, 50, 50))
            box:SetConVar("mcompass_enabled")
            box:SetValue(GetConVar("mcompass_enabled"):GetInt())
            box:SizeToContents()
            panel:AddItem(box)
            local box2 = vgui.Create("DCheckBoxLabel", panel)
            box2:SetText("Show Heading")
            box2:SetTextColor(Color(50, 50, 50))
            box2:SetConVar("mcompass_heading")
            box2:SetValue(GetConVar("mcompass_heading"):GetInt())
            box2:SizeToContents()
            panel:AddItem(box2)
            panel:NumSlider("Style", "mcompass_style", 1, 3, 0)
            panel:NumSlider("X Position", "mcompass_xposition", 0, 1)
            panel:NumSlider("Y Position", "mcompass_yposition", 0, 1)
            panel:NumSlider("Width", "mcompass_width", 0, 1)
            panel:NumSlider("Height", "mcompass_height", 0, 1)
            panel:NumSlider("Spacing", "mcompass_spacing", 1, 10, 2)
            panel:NumSlider("Ratio (font size)", "mcompass_ratio", 0.1, 10)
            local mixercolor = string.ToColor(GetConVar("mcompass_color"):GetString())
            local mixer = vgui.Create("DColorMixer", panel)
            mixer:SizeToContents()
            mixer:SetColor(mixercolor)
            panel:AddItem(mixer)
            local but1 = vgui.Create("DButton", panel)
            but1:SetText("Set Color")
            but1.DoClick = function()
                local c = mixer:GetColor()
                RunConsoleCommand("mcompass_color", tostring(c.r) .. " " .. tostring(c.g) .. " " .. tostring(c.b) .. " " .. tostring(c.a))
            end

            panel:AddItem(but1)
            local but2 = vgui.Create("DButton", panel)
            but2:SetText("Reset Settings")
            but2.DoClick = function() RunConsoleCommand("mcompass_reset") end
            panel:AddItem(but2)
        end)
    end)
end