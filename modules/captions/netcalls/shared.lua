if SERVER then
    util.AddNetworkString("StartCaption")
    util.AddNetworkString("EndCaption")
else
    net.Receive("StartCaption", function()
        local text = net.ReadString()
        local duration = net.ReadFloat()
        lia.caption.start(text, duration)
    end)

    net.Receive("EndCaption", function() lia.caption.finish() end)
end