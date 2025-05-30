﻿MODULE.name = "Broadcasts"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.1"
MODULE.desc = "Adds a Faction & Class Broadcast Command"
MODULE.Public = true
MODULE.CAMIPrivileges = {
    {
        Name = "Staff Permissions - Can Use Faction Broadcast",
        MinAccess = "superadmin",
        Description = "Allows access to Faction Broadcast",
    },
    {
        Name = "Staff Permissions - Can Use Class Broadcast",
        MinAccess = "superadmin",
        Description = "Allows access to Class Broadcast.",
    }
}

lia.flag.add("B", "Access to Faction Broadcast")
lia.flag.add("D", "Access to Class Broadcast")
