MODULE.name = "BodyGroup Closet"
MODULE.versionID = "public_bodygrouper"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.0
MODULE.desc = "Spawns a bodygroup closet where players can edit their model's bodygroups. Admins may inspect others and configure the closet's model."
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

MODULE.NetworkStrings = {"BodygrouperMenu", "BodygrouperMenuClose", "BodygrouperMenuCloseClientside"}

MODULE.Changelog = {
    ["1.0"] = "Initial Release",
}

