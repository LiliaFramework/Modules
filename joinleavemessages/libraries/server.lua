﻿function MODULE:PlayerDisconnected(client)
    local message = L("playerLeft", client:Nick())
    for _, ply in player.Iterator() do
        ClientAddText(ply, Color(255, 0, 0), message)
    end
end

function MODULE:PlayerInitialSpawn(client)
    local message = L("playerJoined", client:Nick())
    for _, ply in player.Iterator() do
        ClientAddText(ply, Color(0, 255, 0), message)
    end
end