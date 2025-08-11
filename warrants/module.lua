MODULE.name = "moduleWarrantSystemName"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.31
MODULE.Public = true
MODULE.desc = "moduleWarrantSystemDesc"
MODULE.Features = {"Adds ability to issue and remove player warrants", "Adds notifications displayed to players", "Adds logging of all warrant actions", "Adds CAMI privileges for warrant management", "Adds timed expiration for warrants"}
MODULE.Privileges = {
    {
        Name = "canWarrantPeople",
        ID = "canWarrantPeople",
        MinAccess = "superadmin",
        Category = "Warrants",
    },
    {
        Name = "canSeeWarrants",
        ID = "canSeeWarrants",
        MinAccess = "superadmin",
        Category = "Warrants",
    },
    {
        Name = "canSeeWarrantNotifications",
        ID = "canSeeWarrantNotifications",
        MinAccess = "superadmin",
        Category = "Warrants",
    },
}