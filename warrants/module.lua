MODULE.name = "Warrant System"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.25
MODULE.Public = true
MODULE.desc = "Allows staff to issue and remove player warrants while notifying everyone involved."
MODULE.Features = {"Adds ability to issue and remove player warrants", "Adds notifications displayed to players", "Adds logging of all warrant actions", "Adds CAMI privileges for warrant management", "Adds timed expiration for warrants"}
MODULE.CAMIPrivileges = {
    {
        Name = "Staff Permissions - Can Warrant People",
        MinAccess = "superadmin",
    },
    {
        Name = "Staff Permissions - Can See Warrants",
        MinAccess = "superadmin",
    },
    {
        Name = "Staff Permissions - Can See Warrant Notifications",
        MinAccess = "superadmin",
    },
}