----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
lia.command.add(
    "removeties",
    {
        privilege = "Characters - Remove Ties",
        adminOnly = true,
        syntax = "<string player>",
        onRun = function(client, arguments)
            local target = lia.command.findPlayer(client, arguments[1])
            if not target then return end
            OnHandcuffRemove(target)
        end
    }
)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------