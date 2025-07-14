if SERVER then
    function lia.caption.start(client, text, duration)
        net.Start("StartCaption")
        net.WriteString(text)
        net.WriteFloat(duration)
        net.Send(client)
        hook.Run("CaptionStarted", client, text, duration)
    end

    function lia.caption.finish(client)
        net.Start("EndCaption")
        net.Send(client)
        hook.Run("CaptionFinished", client)
    end

    local networkStrings = {"StartCaption", "EndCaption"}
    for _, netString in ipairs(networkStrings) do
        util.AddNetworkString(netString)
    end
else
    function lia.caption.start(text, duration)
        RunConsoleCommand("closecaption", "1")
        gui.AddCaption(text, duration or string.len(text) * 0.1)
        hook.Run("CaptionStarted", text, duration)
    end

    function lia.caption.finish()
        RunConsoleCommand("closecaption", "1")
        gui.AddCaption("", 0)
        hook.Run("CaptionFinished")
    end
end
