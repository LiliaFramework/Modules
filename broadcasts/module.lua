MODULE.name = "Broadcasts"
MODULE.versionID = "public_broadcasts"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.0
MODULE.desc = "Lets staff send messages to specific factions or classes."
MODULE.Privileges = {
    ["canUseFactionBroadcast"] = {
        Name = "canUseFactionBroadcast",
        MinAccess = "superadmin",
        Category = "broadcasts",
    },
    ["canUseClassBroadcast"] = {
        Name = "canUseClassBroadcast",
        MinAccess = "superadmin",
        Category = "broadcasts",
    }
}

lia.flag.add("B", "Access to Faction Broadcast")
lia.flag.add("D", "Access to Class Broadcast")
MODULE.Changelog = {
    ["1.0"] = {"Initial Release"},
}
