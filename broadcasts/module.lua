MODULE.name = "Broadcasts"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.4"
MODULE.desc = "Adds a Faction & Class Broadcast Command"
MODULE.Public = true

if SERVER then
    lia.log.addType("classbroadcast", function(client, message)
        return string.format("%s sent class broadcast: %s", client:Name(), message)
    end, "Player")

    lia.log.addType("factionbroadcast", function(client, message)
        return string.format("%s sent faction broadcast: %s", client:Name(), message)
    end, "Player")
end
MODULE.CAMIPrivileges = {
    {
        Name = "Staff Permissions - Can Use Faction Broadcast",
        MinAccess = "superadmin",
    },
    {
        Name = "Staff Permissions - Can Use Class Broadcast",
        MinAccess = "superadmin",
    }
}

lia.flag.add("B", "Access to Faction Broadcast")
lia.flag.add("D", "Access to Class Broadcast")