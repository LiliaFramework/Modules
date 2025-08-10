MODULE.name = "bodygrouperModuleName"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.28
MODULE.desc = "bodygrouperModuleDesc"
MODULE.Public = true
MODULE.Features = {"Adds a spawnable closet entity for editing bodygroups", "Adds the ability to customize its model via BodyGrouperModel", "Adds menu access that requires proximity or privilege", "Adds an admin command to view another player's bodygroups", "Adds a networked menu for editing bodygroups"}
MODULE.Privileges = {
    {
        Name = "Manage Bodygroups",
        MinAccess = "admin",
        Category = "Bodygroups",
    },
    {
        Name = "Change Bodygroups",
        MinAccess = "admin",
        Category = "Bodygroups",
    }
}
