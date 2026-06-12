MODULE.name = "Gamemaster Points"
MODULE.versionID = "public_gamemasterpoints"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.0
MODULE.desc = "Lets game masters save and use teleport points."
MODULE.Privileges = {
    ["manageGamemasterTeleportPoints"] = {
        Name = "manageGamemasterTeleportPoints",
        MinAccess = "admin",
        Category = "gamemasterPoints",
    }
}

MODULE.NetworkStrings = {"GMTPDelete", "GMTPMove", "GMTPNewPoint", "GMTPUpdateEffect", "GMTPUpdateName", "GMTPUpdateSound", "gmTPMenu", "gmTPNewName"}
MODULE.Changelog = {
    ["1.0"] = {"Initial Release"},
}
