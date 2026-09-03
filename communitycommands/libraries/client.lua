net.Receive("OpenCommunityURL", function()
    local commandName = net.ReadString()
    local url = net.ReadString()
    local openIngame = net.ReadBool()
    if url and url ~= "" then
        if openIngame then
            local URLPanel = vgui.Create("DFrame")
            URLPanel:SetTitle(commandName)
            URLPanel:SetSize(ScrW() * 0.8, ScrH() * 0.8)
            URLPanel:Center()
            URLPanel:MakePopup()
            local html = vgui.Create("DHTML", URLPanel)
            html:Dock(FILL)
            html:OpenURL(url)
        else
            gui.OpenURL(url)
        end
    else
        chat.AddText(Color(255, 0, 0), "Invalid URL received.")
    end
end)
