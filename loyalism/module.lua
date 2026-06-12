MODULE.name = "Loyalism"
MODULE.versionID = "public_loyalism"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.0
MODULE.desc = "Adds a loyalty tier system for players."
lia.flag.add("T", "Access to /partytier")
MODULE.Privileges = {
    ["managementAssignPartyTiers"] = {
        Name = "managementAssignPartyTiers",
        MinAccess = "admin",
        Category = "loyalism",
    }
}

MODULE.Changelog = {
    ["1.0"] = {"Initial Release"},
}
