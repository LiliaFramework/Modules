net.Receive("TriggerCinematic", function()
    contents.text = net.ReadString()
    contents.bigText = net.ReadString()
    contents.duration = net.ReadUInt(6)
    local blackbars = net.ReadBool()
    contents.music = net.ReadBool()
    contents.color = net.ReadColor()
    if contents.text == "" then contents.text = nil end
    if contents.bigText == "" then contents.bigText = nil end
    local splashText = vgui.Create("CinematicSplashText")
    if blackbars then
        splashText:DrawBlackBars()
        splashText:TriggerBlackBars()
    else
        splashText:TriggerText()
    end
end)

net.Receive("openCinematicSplashMenu", function() vgui.Create("CinematicSplashTextMenu") end)
