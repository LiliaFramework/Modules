lia.command.add("warrant", {
    adminOnly = false,
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if client:CanWarrantPlayers() then
            if IsValid(target) and target:getChar() then
                target:ToggleWanted(client)
            else
                client:notify("Target player not found or invalid.")
            end
        else
            client:notify("You do not have permission to run this command!")
        end
    end
})