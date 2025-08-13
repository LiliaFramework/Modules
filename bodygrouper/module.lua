MODULE.name = "Body Group Editor"
MODULE.uniqueID = "public_bodygrouper"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.35
MODULE.desc = "Spawns a bodygroup closet where players can edit their model's bodygroups. Admins may inspect others and configure the closet's model."
MODULE.Features = {"Adds a spawnable closet entity for editing bodygroups", "Adds the ability to customize its model via BodyGrouperModel", "Adds menu access that requires proximity or privilege", "Adds an admin command to view another player's bodygroups", "Adds a networked menu for editing bodygroups"}
MODULE.Privileges = {
    {
        Name = "manageBodygroups",
        ID = "manageBodygroups",
        MinAccess = "admin",
        Category = "bodygroups",
    },
    {
        Name = "changeBodygroups",
        ID = "changeBodygroups",
        MinAccess = "admin",
        Category = "bodygroups",
    }
}