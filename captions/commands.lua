lia.command.add("sendCaption", {
    adminOnly = true,
    arguments = {
        {
            name = "target",
            type = "player"
        },
        {
            name = "caption",
            type = "string"
        },
        {
            name = "duration",
            type = "number",
            optional = true
        }
    },
    desc = "sendCaptionDesc",
    AdminStick = {
        Name = "sendCaptionDesc",
        Category = "moderationTools",
        SubCategory = "captions"
    },
    onRun = function(client, arguments)
        local target = lia.util.findPlayer(client, arguments[1])
        local text = arguments[2]
        local duration = tonumber(arguments[3]) or 5
        if not target or not IsValid(target) then
            client:notifyLocalized("targetNotFound")
            return
        end

        if text then
            hook.Run("SendCaptionCommand", client, target, text, duration)
            lia.caption.start(target, text, duration)
        else
            client:notifyLocalized("sendCaptionError")
        end
    end
})

lia.command.add("broadcastCaption", {
    adminOnly = true,
    arguments = {
        {
            name = "caption",
            type = "string"
        },
        {
            name = "duration",
            type = "number",
            optional = true
        }
    },
    desc = "broadcastCaptionDesc",
    onRun = function(client, arguments)
        local text = arguments[1]
        local duration = tonumber(arguments[2]) or 5
        if text then
            hook.Run("BroadcastCaptionCommand", client, text, duration)
            for _, target in player.Iterator() do
                lia.caption.start(target, text, duration)
            end
        else
            client:notifyLocalized("broadcastCaptionError")
        end
    end
})
