if SERVER then
--[[
    lia.caption.start(client, text, duration)

    Description:
        Sends a caption to the specified player for the given duration.

    Parameters:
        client (Player) – Target player.
        text (string) – Caption text to display.
        duration (number) – Time in seconds the caption should remain.

    Realm:
        Server

    Example:
        lia.caption.start(ply, "Access Granted", 5)

    Returns:
        nil
    ]]
    function lia.caption.start(client, text, duration)
        net.Start("StartCaption")
        net.WriteString(text)
        net.WriteFloat(duration)
        net.Send(client)
    end

--[[
    lia.caption.finish(client)

    Description:
        Clears any caption currently displayed to the player.

    Parameters:
        client (Player) – Target player.

    Realm:
        Server

    Example:
        lia.caption.finish(ply)

    Returns:
        nil
    ]]
    function lia.caption.finish(client)
        net.Start("EndCaption")
        net.Send(client)
    end

    local networkStrings = {"StartCaption", "EndCaption",}
    for _, netString in ipairs(networkStrings) do
        util.AddNetworkString(netString)
    end
else
    --[[
    lia.caption.start(text, duration)

    Description:
        Displays a caption on the local player's screen.

    Parameters:
        text (string) – Caption text to display.
        duration (number) – Time in seconds the caption should remain.

    Realm:
        Client

    Example:
        lia.caption.start("Access Granted", 5)

    Returns:
        nil
    ]]
    function lia.caption.start(text, duration)
        RunConsoleCommand("closecaption", "1")
        gui.AddCaption(text, duration or string.len(text) * 0.1)
    end

    --[[
    lia.caption.finish()

    Description:
        Removes any caption shown on the local player's screen.

    Realm:
        Client

    Example:
        lia.caption.finish()

    Returns:
        nil
    ]]
    function lia.caption.finish()
        RunConsoleCommand("closecaption", "1")
        gui.AddCaption("", 0)
    end
end