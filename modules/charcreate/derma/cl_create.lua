------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local MODULE = MODULE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:Create(parent, gr)
    local payload = {}
    gr.p = parent:Add("EditablePanel")
    gr.p:SetSize(ScrW(), ScrH())
    function gr.p:Think()
        gr.p:Center()
    end

    function gr.p:Paint(w, h)
        lia.util.drawBlur(self, 4)
        draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 100))
    end

    gr.p:SizeTo(
        ScrW() / 2,
        ScrH() / 2,
        0.15,
        0,
        0.8,
        function()
            local p = gr.p
            local title = p:Add("DLabel")
            title:SetText("Create Character")
            title:SetFont("WB_Large")
            title:SizeToContents()
            title:SetPos(0, 30)
            title:CenterHorizontal()
            --Steps
            local scroll = p:Add("DScrollPanel")
            scroll:SetSize(p:GetWide(), 30)
            scroll:SetPos(0, title:GetY() + 25)
            local list = scroll:Add("DIconLayout")
            list:SetSize(scroll:GetSize())
            --Draw Functions
            local teDraw = function(panel, w, h)
                if panel:IsEditing() then
                    draw.RoundedBox(6, 0, 0, w, h, Color(255, 255, 255))
                else
                    draw.RoundedBox(6, 0, 0, w, h, Color(235, 235, 235))
                end

                panel:DrawTextEntryText(color_black, Color(75, 75, 225), color_black)
            end

            local steps = {
                {
                    name = "First/Last Name",
                    run = function(panel, grp)
                        grp.firstname = panel:Add("DTextEntry")
                        grp.firstname:SetSize(200, 35)
                        grp.firstname:CenterHorizontal()
                        grp.firstname:CenterVertical(0.40)
                        grp.firstname.Paint = teDraw
                        grp.firstname:SetPlaceholder("First Name")
                        grp.lastname = panel:Add("DTextEntry")
                        grp.lastname:SetSize(200, 35)
                        follow(grp.lastname, grp.firstname, BOTTOM)
                        grp.lastname.Paint = teDraw
                        grp.lastname:SetPlaceholder("Last Name")
                        --TAB Like behavior
                        function grp.firstname:OnEnter()
                            grp.lastname:RequestFocus()
                        end
                    end,
                    getVal = function(grp, payload)
                        --Uppercasing first character
                        function firstToUpper(str)
                            return str:gsub("^%l", string.upper)
                        end

                        payload.name = firstToUpper(grp.firstname:GetText()) .. " " .. firstToUpper(grp.lastname:GetText())
                    end,
                    canProceed = function(grp)
                        if not grp.firstname or not IsValid(grp.firstname) then return end
                        if not grp.lastname or not IsValid(grp.lastname) then return end
                        local fn = grp.firstname:GetText()
                        if fn == grp.firstname.placeholder then fn = nil end
                        local ln = grp.lastname:GetText()
                        if ln == grp.lastname.placeholder then ln = nil end
                        return fn and ln
                    end
                },
                {
                    name = "Details",
                    run = function(panel, grp)
                        grp.scroll = panel:Add("WScrollList")
                        grp.scroll:SetSize(panel:GetWide(), 200)
                        grp.scroll:CenterHorizontal()
                        grp.scroll:CenterVertical(0.55)
                        grp.list = grp.scroll:GetList()
                        local fields = {
                            ["Eye Color"] = {"Green", "Blue", "Brown", "Black", "Amber"},
                            ["Hair Color"] = {"Black", "Brown", "Blond", "Grey", "Bald", "Auburn"},
                            ["Blood Type"] = {"O-", "O+", "A-", "A+", "B-", "B+", "AB+", "AB-"},
                            ["Ethnicity"] = {"Ukranian", "Turkic", "Russian", "Romanian", "Jewish", "Hungarian", "Finnish", "Caucasian", "Byelorussian", "Baltic", "Danish", "Dutch", "French", "German", "Italian", "Japanese", "Polish", "Swedish"},
                            ["Age"] = function(val) return val .. " years old" end,
                            ["Weight"] = function(val) return val .. " lbs" end,
                            ["Height"] = function(val) end
                        }

                        grp.fieldTe = {}
                        for k, v in pairs(fields) do
                            local fp = grp.list:Add("DPanel")
                            fp:SetSize(grp.list:GetWide() / 2 - 1, 65)
                            function fp:Paint(w, h)
                                draw.RoundedBox(0, 0, 0, w, h, Color(45, 45, 45))
                            end

                            fp.name = fp:Add("DLabel")
                            fp.name:SetText(k)
                            fp.name:SetFont("WB_Medium")
                            fp.name:SetColor(color_white)
                            fp.name:SizeToContents()
                            fp.name:SetPos(0, 5)
                            fp.name:CenterHorizontal()
                            local sName = k:Replace(" ", ""):lower() --Simplified name (no space, lowered)
                            --Adding TE or ComboBox
                            if not istable(v) then
                                fp.te = fp:Add("DTextEntry")
                                fp.te.Paint = teDraw
                                fp.te.format = v
                                fp.te:SetNumeric(true)
                                fp.te:SetTall(30)
                                if k == "Height" then
                                    fp.te:SetPos(10, fp:GetTall() - fp.te:GetTall() - 10)
                                    fp.te:SetWide(fp:GetWide() / 2 - 10)
                                    fp.te:SetPlaceholder("Feet")
                                    fp.inches = fp:Add("DTextEntry")
                                    fp.inches.Paint = teDraw
                                    fp.inches:SetNumeric(true)
                                    fp.inches:SetSize(fp:GetWide() / 2 - 20, 30)
                                    fp.inches:SetPos(fp:GetWide() - fp.inches:GetWide() - 10, fp:GetTall() - fp.inches:GetTall() - 10)
                                    fp.inches:SetPlaceholder("Inches")
                                    grp.fieldTe["inches"] = fp.inches
                                else
                                    fp.te:Dock(BOTTOM)
                                    fp.te:DockMargin(10, 10, 10, 10)
                                end

                                grp.fieldTe[sName] = fp.te
                            else
                                fp.combo = fp:Add("DComboBox")
                                fp.combo:SetTall(30)
                                fp.combo:Dock(BOTTOM)
                                fp.combo:DockMargin(10, 10, 10, 10)
                                fp.combo.isCombo = true
                                function fp.combo:Paint(w, h)
                                    local col = Color(235, 235, 235)
                                    if self:IsHovered() or self:IsMenuOpen() then col = color_white end
                                    draw.RoundedBox(6, 0, 0, w, h, col)
                                end

                                for _, v in pairs(fields[k]) do
                                    fp.combo:AddChoice(v)
                                end

                                fp.combo:ChooseOption(fields[k][1])
                                grp.fieldTe[sName] = fp.combo
                            end
                        end
                    end,
                    canProceed = function(grp)
                        if not grp or not grp.fieldTe then return false end
                        local fields = grp.fieldTe
                        for k, v in pairs(fields) do
                            if not v or not IsValid(v) then continue end
                            local val = v:GetText()
                            if val == nil or val == "" then return false end
                        end
                        return true
                    end,
                    getVal = function(grp, payload)
                        local fields = grp.fieldTe
                        payload.data = {}
                        payload.data.info = {}
                        --Getting the details from the textentries
                        local d = {}
                        for k, v in pairs(fields) do
                            if k == "height" then
                                local inches = fields["inches"]:GetText()
                                local feet = v:GetText()
                                local height = feet .. "'" .. inches
                                payload.data.info.height = height
                            elseif k == "inches" then
                                continue
                            elseif v.isCombo then
                                payload.data.info[k] = v:GetSelected() or v:GetOptionText(1)
                            else
                                payload.data.info[k] = v.format(v:GetText())
                            end
                        end

                        grp.fieldTe = nil --Remove the field table so it doesn't wreck havoc
                    end
                },
                {
                    name = "Appearance",
                    run = function(pnl, grp)
                        local defaultFaction = nil
                        for _, faction in pairs(lia.faction.indices) do
                            if faction.isDefault then
                                defaultFaction = faction
                                break
                            end
                        end

                        if not defaultFaction then
                            Error("Default faction not found!")
                            return
                        end

                        grp.scroll = pnl:Add("WScrollList")
                        grp.scroll:SetSize(pnl:GetWide(), 200)
                        grp.scroll:CenterHorizontal()
                        grp.scroll:CenterVertical(0.55)
                        grp.list = grp.scroll:GetList()
                        grp.curSel = nil
                        for k, v in pairs(defaultFaction.models) do
                            local mp = grp.list:Add("DPanel")
                            mp:SetSize(grp.list:GetWide() / 4 - 2, grp.scroll:GetTall() / 2)
                            function mp:Paint(w, h)
                                local col = Color(45, 45, 45)
                                --Change color if sel
                                if grp.curSel == k then col = BC_NEUTRAL end
                                draw.RoundedBox(0, 0, 0, w, h, col)
                            end

                            local mdl = mp:Add("DModelPanel")
                            mdl:Dock(FILL)
                            mdl:SetModel(v)
                            mdl:SetFOV(35)
                            function mdl:LayoutEntity(ent)
                                ent:SetAngles(Angle(0, 45, 0))
                            end

                            function mdl:DoClick()
                                grp.curSel = k
                            end

                            --Aim the cam at head
                            local head = mdl.Entity:LookupBone("ValveBiped.Bip01_Head1")
                            if head and head > 0 then
                                local headpos = mdl.Entity:GetBonePosition(head)
                                mdl:SetLookAt(headpos)
                            end
                        end
                    end,
                    canProceed = function(grp) if grp and grp.curSel and grp.curSel > 0 then return true end end,
                    getVal = function(grp, payload)
                        payload.model = grp.curSel
                        grp.curSel = nil
                    end
                },
                {
                    name = "Completion",
                    run = function(panel, grp)
                        local checking = panel:Add("DLabel")
                        checking:SetText("Checking info...")
                        checking:SetFont("WB_Large")
                        checking:SetColor(color_white)
                        function checking:Think()
                            self:SizeToContents()
                            self:Center()
                        end

                        payload.faction = MODULE.defaultFaction
                        payload.desc = MODULE:generateDesc(payload)
                        local verifiedPayload = {}
                        for key, charVar in pairs(lia.char.vars) do
                            if charVar.noDisplay then continue end
                            local value = payload[key]
                            if isfunction(charVar.onValidate) then
                                local results = {charVar.onValidate(value, payload, LocalPlayer())}
                                if results[1] == false then return end
                            end

                            verifiedPayload[key] = value
                        end

                        --PrintTable(verifiedPayload)
                        --[[
          ]]
                        net.Start("liaCharCreate")
                        net.WriteUInt(table.Count(verifiedPayload), 32)
                        for key, value in pairs(verifiedPayload) do
                            net.WriteString(key)
                            net.WriteType(value)
                        end

                        net.SendToServer()
                        net.Receive(
                            "liaCharCreate",
                            function()
                                local id = net.ReadUInt(32)
                                local msg = net.ReadString()
                                if id <= 0 then
                                    --lia.util.notify(L(msg), NOT_ERROR)
                                    checking:SetText(L(msg))
                                    checking:SetColor(Color(255, 0, 0, 255))
                                    return
                                end

                                checking:SetText("Character Created!")
                                checking:ColorTo(Color(75, 225, 75), 0.5)
                                timer.Simple(
                                    1,
                                    function()
                                        gr.p:AlphaTo(
                                            0,
                                            0.3,
                                            0,
                                            function()
                                                gr.p:Remove() --Removing char create panel
                                                --Loading the character
                                                MODULE:ChooseCharacter(parent, id)
                                            end
                                        )
                                    end
                                )
                            end
                        )
                    end,
                    --[[
          netstream.Start("charCreate", payload)
          netstream.Hook("charAuthed", function(fault,...)
            if type(fault) == "string" then
              lia.util.notify(L(fault,...), NOT_ERROR)
              return
            end

            if type(fault) == "table" then
              lia.characters = fault
            end

            checking:SetText("Character Created!")
            checking:ColorTo(Color(75,225,75), 0.5)

            timer.Simple(1, function()
              gr.p:AlphaTo(0, 0.3, 0, function()
                gr.p:Remove() --Removing char create panel

                --Loading the character
                MODULE:ChooseCharacter(parent, lia.characters[#lia.characters], true)
              end)
            end)
          end)
          ]]
                    canProceed = function() return false end,
                    getVal = function() end
                }
            }

            local function getVert(w, h, num)
                local vert = {}
                if num == 1 then
                    vert = {
                        {
                            x = 0,
                            y = 0
                        },
                        {
                            x = w - 10,
                            y = 0
                        },
                        {
                            x = w,
                            y = h / 2
                        },
                        {
                            x = w - 10,
                            y = h
                        },
                        {
                            x = 0,
                            y = h
                        }
                    }
                elseif num == #steps then
                    vert = {
                        {
                            x = 10,
                            y = h / 2
                        },
                        {
                            x = 0,
                            y = 0
                        },
                        {
                            x = w,
                            y = 0
                        },
                        {
                            x = w,
                            y = h
                        },
                        {
                            x = 0,
                            y = h
                        }
                    }
                else
                    vert = {
                        {
                            x = 10,
                            y = 0
                        },
                        {
                            x = w - 10,
                            y = 0
                        },
                        {
                            x = w,
                            y = h / 2
                        },
                        {
                            x = w - 10,
                            y = h
                        },
                        {
                            x = 10,
                            y = h
                        }
                    }

                    vert2 = {
                        {
                            x = 0,
                            y = 0
                        },
                        {
                            x = 10,
                            y = 0
                        },
                        {
                            x = 10,
                            y = h / 2
                        }
                    }

                    vert3 = {
                        {
                            x = 10,
                            y = h / 2
                        },
                        {
                            x = 10,
                            y = h
                        },
                        {
                            x = 0,
                            y = h
                        }
                    }
                end
                return vert, vert2, vert3
            end

            local curStep = 0
            local function addStep(name, num)
                local s = list:Add("DLabel")
                s:SetText(name)
                s:SetFont("WB_Medium")
                s:SetColor(color_white)
                s:SetContentAlignment(5)
                s:SetSize(scroll:GetWide() / table.Count(steps), scroll:GetTall())
                function s:Paint(w, h)
                    vert, v2, v3 = getVert(w, h, num)
                    if curStep >= num then
                        surface.SetDrawColor(BC_NEUTRAL)
                    else
                        surface.SetDrawColor(Color(45, 45, 45))
                    end

                    draw.NoTexture()
                    surface.DrawPoly(vert)
                    if v2 then surface.DrawPoly(v2) end
                    if v3 then surface.DrawPoly(v3) end
                end
            end

            --Adding steps to the list
            for k, v in pairs(steps) do
                addStep(v.name, k)
            end

            --Displaying steps
            local wpg = group()
            local wp = p:Add("DPanel")
            wp:SetSize(p:GetWide(), p:GetTall() - (30 + title:GetTall() + scroll:GetTall() + 30))
            wp:SetPos(0, 30 + title:GetTall() + scroll:GetTall() + 25)
            function wp:Paint(w, h)
                surface.SetDrawColor(60, 60, 60, 80)
                surface.DrawLine(0, 0, w, 0)
            end

            local function displayStep(step)
                local func = steps[step].run
                wpg:FadeOutRem(
                    function()
                        wpg = group()
                        func(wp, wpg)
                        wpg.title = wp:Add("DLabel")
                        wpg.title:SetText(steps[step].name)
                        wpg.title:SetFont("WB_Large")
                        wpg.title:SetColor(color_white)
                        wpg.title:SizeToContents()
                        wpg.title:CenterHorizontal()
                        wpg.title:CenterVertical(0.2)
                        wpg:FadeIn()
                    end,
                    true
                )

                --Clearing
                --Continue button
                local proc = wp:Add("WButton")
                proc:SetSize(wp:GetWide() - 100, 40)
                proc:SetText("Continue")
                proc:SetAccentColor(BC_NEUTRAL)
                proc:SetPos(0, wp:GetTall() - proc:GetTall() - 10)
                proc:CenterHorizontal()
                function proc:Think()
                    local s = steps[step]
                    if s.canProceed and not s.canProceed(wpg) then
                        self:SetAccentColor(Color(100, 100, 100))
                        self:SetDisabled(true)
                    else
                        self:SetAccentColor(BC_NEUTRAL)
                        self:SetDisabled(false)
                    end
                end

                function proc:DoClick()
                    local s = steps[step]
                    if s.canProceed and not s.canProceed(wpg) then return end
                    s.getVal(wpg, payload)
                    if steps[step + 1] then displayStep(step + 1) end
                end

                curStep = step
            end

            displayStep(1)
        end
    )
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
