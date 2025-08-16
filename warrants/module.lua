MODULE.name = "Warrant System"
MODULE.uniqueID = "public_warrants"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.38
MODULE.desc = "Adds ability to issue and remove player warrants, notifications displayed to players, logging of all warrant actions, CAMI privileges for warrant management, and timed expiration for warrants."
MODULE.Privileges = {
    {
        Name = "canWarrantPeople",
        ID = "canWarrantPeople",
        MinAccess = "superadmin",
        Category = "warrants",
    },
    {
        Name = "canSeeWarrants",
        ID = "canSeeWarrants",
        MinAccess = "superadmin",
        Category = "warrants",
    },
    {
        Name = "canSeeWarrantNotifications",
        ID = "canSeeWarrantNotifications",
        MinAccess = "superadmin",
        Category = "warrants",
    },
}
