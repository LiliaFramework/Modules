lia.caption = lia.caption or {}
if SERVER then
    function lia.caption.start(client, text, duration)
        net.Start("StartCaption")
        net.WriteString(text)
        net.WriteFloat(duration)
        net.Send(client)
    end

    function lia.caption.finish(client)
        net.Start("EndCaption")
        net.Send(client)
    end
else
    function lia.caption.start(text, duration)
        RunConsoleCommand("closecaption", "1")
        gui.AddCaption(text, duration or string.len(text) * 0.1)
    end

    function lia.caption.finish()
        RunConsoleCommand("closecaption", "1")
        gui.AddCaption("", 0)
    end
end
