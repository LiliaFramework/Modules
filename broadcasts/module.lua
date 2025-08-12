MODULE.name = "Broadcasts"
MODULE.uniqueID = "broadcasts"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.28
MODULE.Public = true
MODULE.desc = "Allows staff to broadcast messages to chosen factions or classes. Every broadcast is logged and controlled through CAMI privileges."
MODULE.Features = {"Adds faction and class broadcast commands with CAMI checks", "Adds logging of broadcast messages for staff review", "Adds CAMI privileges for broadcast access", "Adds menus to select factions or classes"}
MODULE.Privileges = {
    {
        Name = "canUseFactionBroadcast",
        ID = "canUseFactionBroadcast",
        MinAccess = "superadmin",
        Category = "Broadcasts",
    },
    {
        Name = "canUseClassBroadcast",
        ID = "canUseClassBroadcast",
        MinAccess = "superadmin",
        Category = "Broadcasts",
    }
}

lia.flag.add("B", "Access to Faction Broadcast")
lia.flag.add("D", "Access to Class Broadcast")