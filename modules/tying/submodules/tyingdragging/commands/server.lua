lia.command.add("stopdragging", {
    privilege = "Stop Dragging",
    adminOnly = true,
    syntax = "<string player>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if not target then return end
        SetDrag(target, client, false)
    end
})
