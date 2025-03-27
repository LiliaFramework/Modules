lia.command.add("sendCaption", {
    adminOnly = true,
    syntax = "[string targetPlayer] [string caption] [number duration]",
    desc = "Sends a caption message to a specific player for a set duration.",
    onRun = function(client, arguments)
        local target = lia.util.findPlayer(client, arguments[1])
        local text = arguments[2]
        local duration = tonumber(arguments[3]) or 5
        if not target or not IsValid(target) then
            client:notifyLocalized("targetNotFound")
            return
        end

        if text then
            lia.caption.start(target, text, duration)
        else
            client:notify("You must provide a valid player and caption text.")
        end
    end
})

lia.command.add("broadcastCaption", {
    adminOnly = true,
    syntax = "[string caption] [number duration]",
    desc = "Broadcasts a caption message to all players for a set duration.",
    onRun = function(client, arguments)
        local text = arguments[1]
        local duration = tonumber(arguments[2]) or 5
        if text then
            for _, target in player.Iterator() do
                lia.caption.start(target, text, duration)
            end
        else
            client:notify("You must provide a caption text.")
        end
    end
})
