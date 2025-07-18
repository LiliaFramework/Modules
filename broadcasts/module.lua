MODULE.name = "Broadcasts"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.20
MODULE.Public = true
MODULE.desc = "Enables faction and class broadcast commands so staff can send messages to specific groups."
MODULE.Features = {"Adds faction and class broadcast commands with CAMI checks", "Adds logging of broadcast messages for staff review", "Adds support for flagged players to send targeted messages", "Adds CAMI privileges for broadcast access", "Adds menus to select factions or classes"}
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