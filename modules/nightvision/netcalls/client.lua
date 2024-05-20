--------------------------------------------------------------------------------------------------------
net.Receive("AM_NightvisionOn", function(len, ply)
    am_nightvision = DynamicLight(0)
    if am_nightvision then
        am_nightvision.Pos = LocalPlayer():EyePos()
        am_nightvision.r = 0
        am_nightvision.g = 100
        am_nightvision.b = 0
        am_nightvision.Brightness = 1
        am_nightvision.Size = 10000
        am_nightvision.DieTime = CurTime() + 100000
        am_nightvision.Style = 1
    end

    timer.Create("AM_LightTimer", 0.05, 0, function() am_nightvision.Pos = LocalPlayer():EyePos() end)
end)

--------------------------------------------------------------------------------------------------------
net.Receive("AM_NightvisionOff", function(len, ply)
    timer.Remove("AM_LightTimer")
    if am_nightvision then am_nightvision.DieTime = CurTime() + 0.1 end
end)
--------------------------------------------------------------------------------------------------------
