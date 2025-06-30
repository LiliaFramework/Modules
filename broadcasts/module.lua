MODULE.name = "Broadcasts"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.3"
MODULE.desc = "Adds a Faction & Class Broadcast Command"
MODULE.Public = true
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