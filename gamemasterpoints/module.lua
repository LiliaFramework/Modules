MODULE.name = "Gamemaster Points"
MODULE.versionID = "public_gamemasterpoints"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.3
MODULE.desc = "Adds teleport points for game masters, quick navigation across large maps, saving of locations for reuse, a command to list saved points, and sharing of points with other staff."
MODULE.Privileges = {
    {
        Name = "manageGamemasterTeleportPoints",
        ID = "manageGamemasterTeleportPoints",
        MinAccess = "admin",
        Category = "gamemasterPoints",
    }
}

MODULE.NetworkStrings = {"GMTPDelete", "GMTPMove", "GMTPNewPoint", "GMTPUpdateEffect", "GMTPUpdateName", "GMTPUpdateSound", "gmTPMenu", "gmTPNewName"}
