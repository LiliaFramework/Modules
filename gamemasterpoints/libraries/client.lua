local MODULE = MODULE
local PANEL = {}
function PANEL:Init()
    self:SetTitle(L("tpPointsTitle"))
    self:SetSize(500, 400)
    self:Center()
    self:MakePopup()
    local notice = self:Add("DLabel")
    notice:Dock(TOP)
    notice:SetText(L("tpNotice"))
    notice:SetTextColor(color_white)
    notice:SetExpensiveShadow(1, color_black)
    notice:SetContentAlignment(8)
    notice:SetFont("LiliaFont.22")
    notice:SizeToContents()
    self.list = self:Add("DScrollPanel")
    self.list:Dock(FILL)
    self.list:DockMargin(0, 5, 0, 0)
    self.list:SetPadding(5)
    local btn = self.list:Add("DButton")
    btn:SetText(L("addNewPoint"))
    btn:SetFont("LiliaFont.16")
    btn:SetTextColor(color_blue)
    btn:SetTall(30)
    btn:Dock(TOP)
    btn:DockMargin(0, 0, 0, 5)
    btn.OnMousePressed = function(_, code)
        if code == MOUSE_LEFT or code == MOUSE_RIGHT then
            surface.PlaySound("buttons/blip1.wav")
            Derma_StringRequest(L("newPointTitle"), L("enterNewTPName"), "", function(text)
                surface.PlaySound("buttons/blip1.wav")
                net.Start("GMTPNewPoint")
                net.WriteString(text)
                net.SendToServer()
                self:Close()
                table.insert(MODULE.TPPoints, {
                    name = text,
                    sound = "",
                    effect = ""
                })

                vgui.Create("gmTPMenu")
            end)
        end
    end

    self:LoadPoints()
end

function PANEL:LoadPoints()
    for k, v in pairs(MODULE.TPPoints) do
        local btn = self.list:Add("DButton")
        btn:SetText(v.name)
        btn:SetFont("LiliaFont.16")
        btn:SetTextColor(color_white)
        btn:SetTall(30)
        btn:Dock(TOP)
        btn:DockMargin(0, 0, 0, 5)
        btn.OnMousePressed = function(_, code)
            if code == MOUSE_LEFT then
                surface.PlaySound("buttons/blip1.wav")
                net.Start("GMTPMove")
                net.WriteString(v.name)
                net.SendToServer()
                self:Close()
            elseif code == MOUSE_RIGHT then
                surface.PlaySound("buttons/blip2.wav")
                local menu = DermaMenu()
                menu:AddOption(L("renamePoint"), function()
                    Derma_StringRequest(L("renameTPPoint"), L("enterNewTPName"), v.name, function(text)
                        surface.PlaySound("buttons/blip1.wav")
                        net.Start("GMTPUpdateName")
                        net.WriteString(v.name)
                        net.WriteString(text)
                        net.SendToServer()
                        self:Close()
                        MODULE.TPPoints[k].name = text
                        vgui.Create("gmTPMenu")
                    end)
                end):SetImage("icon16/comment.png")

                menu:AddOption(L("editSoundEffect"), function()
                    Derma_StringRequest(L("editSoundEffect"), L("soundEffectPrompt"), v.sound, function(text)
                        surface.PlaySound("buttons/blip1.wav")
                        net.Start("GMTPUpdateSound")
                        net.WriteString(v.name)
                        net.WriteString(v.sound)
                        net.WriteString(text or "")
                        net.SendToServer()
                        self:Close()
                        MODULE.TPPoints[k].sound = text or ""
                        vgui.Create("gmTPMenu")
                    end)
                end):SetImage("icon16/sound.png")

                menu:AddOption(L("editParticleEffect"), function()
                    Derma_StringRequest(L("editParticleEffect"), L("particleEffectPrompt"), v.effect, function(text)
                        surface.PlaySound("buttons/blip1.wav")
                        net.Start("GMTPUpdateEffect")
                        net.WriteString(v.name)
                        net.WriteString(v.effect)
                        net.WriteString(text or "")
                        net.SendToServer()
                        self:Close()
                        MODULE.TPPoints[k].effect = text or ""
                        vgui.Create("gmTPMenu")
                    end)
                end):SetImage("icon16/weather_sun.png")

                menu:AddOption(L("moveToPoint"), function()
                    net.Start("GMTPMove")
                    net.WriteString(v.name)
                    net.SendToServer()
                end):SetImage("icon16/door_in.png")

                menu:AddOption(L("deletePoint"), function()
                    net.Start("GMTPDelete")
                    net.WriteString(v.name)
                    net.SendToServer()
                    self:Close()
                    table.remove(MODULE.TPPoints, k)
                    vgui.Create("gmTPMenu")
                end):SetImage("icon16/cross.png")

                menu:Open()
            end
        end

        self.list:AddItem(btn)
    end
end

vgui.Register("gmTPMenu", PANEL, "DFrame")
net.Receive("gmTPMenu", function()
    local data = net.ReadTable()
    MODULE.TPPoints = {}
    for _, n in pairs(data) do
        table.insert(MODULE.TPPoints, n)
    end

    table.sort(MODULE.TPPoints, function(a, b) return a.name < b.name end)
    vgui.Create("gmTPMenu")
end)

net.Receive("gmTPNewName", function()
    local name = net.ReadString()
    Derma_StringRequest(L("renameTPPoint"), L("enterNewTPName"), name, function(text)
        surface.PlaySound("buttons/blip1.wav")
        net.Start("GMTPUpdateName")
        net.WriteString(name)
        net.WriteString(text)
        net.SendToServer()
    end)
end)
