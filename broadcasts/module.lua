MODULE.name = "Broadcasts"
MODULE.versionID = "public_broadcasts"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.2
MODULE.desc = "Allows staff to broadcast messages to chosen factions or classes. Every broadcast is logged and controlled through CAMI privileges."
MODULE.Privileges = {
    {
        Name = "canUseFactionBroadcast",
        ID = "canUseFactionBroadcast",
        MinAccess = "superadmin",
        Category = "broadcasts",
    },
    {
        Name = "canUseClassBroadcast",
        ID = "canUseClassBroadcast",
        MinAccess = "superadmin",
        Category = "broadcasts",
    }
}

lia.flag.add("B", "Access to Faction Broadcast")
lia.flag.add("D", "Access to Class Broadcast")
