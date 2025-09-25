net.Receive("DoorKickView", function()
    LocalPlayer().KickingInDoor = true
    timer.Simple(1.4, function() LocalPlayer().KickingInDoor = false end)
end)
