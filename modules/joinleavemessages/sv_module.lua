--------------------------------------------------------------------------------------------------------------------------
util.AddNetworkString("PlayerJoinedLeftAnnouncement")
--------------------------------------------------------------------------------------------------------------------------
function MODULE:PlayerDisconnected(ply)
    net.Start("PlayerJoinedLeftAnnouncement")
    net.WriteString(ply:Nick() .. " left Berlin.")
    net.WriteBool(false) 
    net.Broadcast()
end
--------------------------------------------------------------------------------------------------------------------------
function MODULE:PlayerInitialSpawn(ply)
    net.Start("PlayerJoinedLeftAnnouncement")
    net.WriteString(ply:Nick() .. " entered Berlin.")
    net.WriteBool(true)
    net.Broadcast()
end
--------------------------------------------------------------------------------------------------------------------------