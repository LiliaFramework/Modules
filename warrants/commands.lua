lia.command.add("warrant", {
    adminOnly = false,
    syntax = "[string targetPlayer]",
    desc = "Toggles a wanted warrant on the specified player.",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if client:CanWarrantPlayers() then
            if IsValid(target) and target:getChar() then
                target:ToggleWanted(client)
            else
                client:notifyLocalized("plyNoExist")
            end
        else
            client:notifyLocalized("noPerm")
        end
    end
})
