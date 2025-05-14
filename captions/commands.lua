lia.command.add("sendCaption", {
    adminOnly = true,
    syntax = "[string targetPlayer] [string caption] [number duration]",
    desc = L("sendCaptionDesc"),
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
            client:notifyLocalized("sendCaptionError")
        end
    end
})

lia.command.add("broadcastCaption", {
    adminOnly = true,
    syntax = "[string caption] [number duration]",
    desc = L("broadcastCaptionDesc"),
    onRun = function(client, arguments)
        local text = arguments[1]
        local duration = tonumber(arguments[2]) or 5
        if text then
            for _, target in player.Iterator() do
                lia.caption.start(target, text, duration)
            end
        else
            client:notifyLocalized("broadcastCaptionError")
        end
    end
})