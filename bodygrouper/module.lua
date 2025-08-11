MODULE.name = "bodygrouperModuleName"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.30
MODULE.desc = "bodygrouperModuleDesc"
MODULE.Public = true
MODULE.Features = {"Adds a spawnable closet entity for editing bodygroups", "Adds the ability to customize its model via BodyGrouperModel", "Adds menu access that requires proximity or privilege", "Adds an admin command to view another player's bodygroups", "Adds a networked menu for editing bodygroups"}
MODULE.Privileges = {
    {
        Name = "manageBodygroups",
        ID = "manageBodygroups",
        MinAccess = "admin",
        Category = "Bodygroups",
    },
    {
        Name = "changeBodygroups",
        ID = "changeBodygroups",
        MinAccess = "admin",
        Category = "Bodygroups",
    }
}
