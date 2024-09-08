--- Helper library for managing caption displays in roleplay scenarios.
-- @library lia.caption
if SERVER then
    --- Sends a request to the client to display a caption message for a specified duration.
    -- @realm server
    -- @param client The client who will receive the caption.
    -- @string text The caption text to display.
    -- @number[opt] duration The duration (in seconds) for which to display the caption (default: 5 seconds).
    function lia.caption.start(client, text, duration)
        net.Start("StartCaption")
        net.WriteString(text)
        net.WriteFloat(duration)
        net.Send(client)
    end

    --- Sends a request to the client to end the caption message.
    -- @realm server
    -- @param client The client who will receive the request to end the caption.
    function lia.caption.finish(client)
        net.Start("EndCaption")
        net.Send(client)
    end
else
    --- Displays a caption message on the screen for a specified duration.
    -- @realm client
    -- @string text The caption text to display.
    -- @number[opt] duration The duration (in seconds) for which to display the caption (default: length-based duration).
    function lia.caption.start(text, duration)
        RunConsoleCommand("closecaption", "1")
        gui.AddCaption(text, duration or string.len(text) * 0.1)
    end

    --- Clears the caption message on the screen.
    -- @realm client
    function lia.caption.finish()
        RunConsoleCommand("closecaption", "1")
        gui.AddCaption("", 0)
    end
end