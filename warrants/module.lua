MODULE.name = "moduleWarrantSystemName"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.30
MODULE.Public = true
MODULE.desc = "moduleWarrantSystemDesc"
MODULE.Features = {"Adds ability to issue and remove player warrants", "Adds notifications displayed to players", "Adds logging of all warrant actions", "Adds CAMI privileges for warrant management", "Adds timed expiration for warrants"}
MODULE.Privileges = {
    {
        Name = "Can Warrant People",
        MinAccess = "superadmin",
        Category = "Warrants",
    },
    {
        Name = "Can See Warrants",
        MinAccess = "superadmin",
        Category = "Warrants",
    },
    {
        Name = "Can See Warrant Notifications",
        MinAccess = "superadmin",
        Category = "Warrants",
    },
}