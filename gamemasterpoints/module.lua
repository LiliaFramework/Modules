MODULE.name = "moduleGamemasterPointsName"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.19
MODULE.desc = "moduleGamemasterPointsDesc"
MODULE.Public = true
MODULE.Features = {"Adds teleport points for game masters", "Adds quick navigation across large maps", "Adds saving of locations for reuse", "Adds a command to list saved points", "Adds sharing of points with other staff"}
MODULE.Privileges = {
    {
        Name = "manageGamemasterTeleportPoints",
        ID = "manageGamemasterTeleportPoints",
        MinAccess = "admin",
        Category = "Gamemaster Points",
    }
}
