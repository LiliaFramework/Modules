lia.command.add("warrant", {
    adminOnly = false,
    syntax = "[string targetPlayer]",
    desc = L("warrantCommandDesc"),
    onRun = function(client, arguments)
        local character = client:getChar()
        local target = lia.util.findPlayer(client, arguments[1])
        if character:CanWarrantPlayers() then
            if IsValid(target) and target:getChar() then
                target:getChar():ToggleWanted(client)
            else
                client:notifyLocalized("plyNoExist")
            end
        else
            client:notifyLocalized("noPerm")
        end
    end
})
