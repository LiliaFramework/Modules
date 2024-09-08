lia.command.add("sendCaption", {
    adminOnly = true,
    syntax = "<string name> <number duration>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        local text = arguments[1]
        local duration = tonumber(arguments[2]) or 5
        if target and text then
            lia.caption.start(target, text, duration)
        else
            client:notify("You must provide a valid player and caption text.")
        end
    end
})

lia.command.add("broadcastCaption", {
    adminOnly = true,
    syntax = "<string text> <number duration>",
    onRun = function(client, arguments)
        local text = arguments[1]
        local duration = tonumber(arguments[2]) or 5
        if text then
            for _, target in ipairs(player.GetAll()) do
                lia.caption.start(target, text, duration)
            end
        else
            client:notify("You must provide a caption text.")
        end
    end
})