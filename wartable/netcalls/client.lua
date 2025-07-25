﻿net.Receive("UseWarTable", function()
    local tableEnt = net.ReadEntity()
    local shouldAct = net.ReadBool()
    local client = LocalPlayer()
    if shouldAct then
        local panel = vgui.Create("DFrame")
        panel:SetTitle("")
        panel:SetSize(ScrW() / 4, 100)
        panel:SetDraggable(false)
        panel:ShowCloseButton(false)
        panel:MakePopup()
        panel:SetPos(ScrW() * 0.5 - panel:GetWide() / 2, ScrH() - panel:GetTall() * 1.25)
        panel.Paint = function(_, w, h) draw.RoundedBox(5, 0, h * 0.25, w, h * 0.75, Color(0, 0, 0, 150)) end
        local clearButton = vgui.Create("DButton", panel)
        clearButton:Dock(TOP)
        clearButton:SetText(L("ClearWarTable"))
        clearButton:SetTextColor(Color(255, 255, 255))
        clearButton.DoClick = function()
            panel:Remove()
            net.Start("ClearWarTable")
            net.WriteEntity(tableEnt)
            net.SendToServer()
        end

        local setMapButton = vgui.Create("DButton", panel)
        setMapButton:Dock(TOP)
        setMapButton:SetText(L("SetNewMapTitle"))
        setMapButton:SetTextColor(Color(255, 255, 255))
        setMapButton.DoClick = function()
            panel:Remove()
            Derma_StringRequest(L("SetNewMapTitle"), L("SetNewMapPrompt"), "", function(text)
                net.Start("SetWarTableMap")
                net.WriteEntity(tableEnt)
                net.WriteString(text)
                net.SendToServer()
            end)
        end

        local exitButton = vgui.Create("DButton", panel)
        exitButton:Dock(TOP)
        exitButton:SetText(L("exit"))
        exitButton:SetTextColor(Color(255, 255, 255))
        exitButton.DoClick = function() panel:Remove() end
    else
        client.LastPos = client:GetPos()
        client.LastAng = client:EyeAngles()
        client.tableEnt = tableEnt
        client.UseWarTable = not client.UseWarTable
        if not client.UseWarTable and IsValid(client.MarkerModel) then client.MarkerModel:Remove() end
    end
end)

net.Receive("SetWarTableMap", function()
    local tableEnt = net.ReadEntity()
    local text = net.ReadString()
    tableEnt:SetMap(text)
end)
