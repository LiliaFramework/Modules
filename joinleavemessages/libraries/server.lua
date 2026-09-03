function MODULE:PlayerDisconnected(client)
    local message = string.format("%s has left the server.", client:Nick())
    for _, ply in player.Iterator() do
        lia.util.addText(ply, Color(255, 0, 0), message)
    end
end

function MODULE:PlayerInitialSpawn(client)
    local message = string.format("%s has joined the server.", client:Nick())
    for _, ply in player.Iterator() do
        lia.util.addText(ply, Color(0, 255, 0), message)
    end
end
