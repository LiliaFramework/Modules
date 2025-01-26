util.AddNetworkString("PlayerJoinedLeftAnnouncement")
function MODULE:PlayerDisconnected(client)
    net.Start("PlayerJoinedLeftAnnouncement")
    net.WriteString(L("playerLeft", client:Nick()))
    net.WriteBool(false)
    net.Broadcast()
end

function MODULE:PlayerInitialSpawn(client)
    net.Start("PlayerJoinedLeftAnnouncement")
    net.WriteString(L("playerJoined", client:Nick()))
    net.WriteBool(true)
    net.Broadcast()
end
