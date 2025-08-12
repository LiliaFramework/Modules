function MODULE:PlayerDisconnected(client)
    local message = L("playerLeft", client:Nick())
    hook.Run("PreJoinLeaveMessageSent", client, false, message)
    for _, ply in player.Iterator() do
        ClientAddText(ply, Color(255, 0, 0), message)
    end

    hook.Run("JoinLeaveMessageSent", client, false, message)
end

function MODULE:PlayerInitialSpawn(client)
    local message = L("playerJoined", client:Nick())
    hook.Run("PreJoinLeaveMessageSent", client, true, message)
    for _, ply in player.Iterator() do
        ClientAddText(ply, Color(0, 255, 0), message)
    end

    hook.Run("JoinLeaveMessageSent", client, true, message)
end