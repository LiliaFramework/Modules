MODULE.name = "Warrant System"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.33
MODULE.Public = true
MODULE.desc = "Adds ability to issue and remove player warrants, notifications displayed to players, logging of all warrant actions, CAMI privileges for warrant management, and timed expiration for warrants."
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