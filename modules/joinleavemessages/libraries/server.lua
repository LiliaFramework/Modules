util.AddNetworkString("PlayerJoinedLeftAnnouncement")
function MODULE:PlayerDisconnected(client)
    net.Start("PlayerJoinedLeftAnnouncement")
    net.WriteString(client:Nick() .. " left the server.")
    net.WriteBool(false)
    net.Broadcast()
end

function MODULE:PlayerInitialSpawn(client)
    net.Start("PlayerJoinedLeftAnnouncement")
    net.WriteString(client:Nick() .. " entered the server.")
    net.WriteBool(true)
    net.Broadcast()
end
