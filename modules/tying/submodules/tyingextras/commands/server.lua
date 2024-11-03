lia.command.add("removeblindfold", {
    privilege = "Remove Blindfold",
    adminOnly = true,
    syntax = "<string player>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if not target then return end
        target:setNetVar("blinded", false)
    end
})

lia.command.add("removegag", {
    privilege = "Remove Gag",
    adminOnly = true,
    syntax = "<string player>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if not target then return end
        target:setNetVar("gagged", false)
    end
})
