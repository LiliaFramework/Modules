lia.command.add("warrant", {
    adminOnly = false,
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