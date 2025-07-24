MODULE.name = "Warrant System"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.26
MODULE.Public = true
MODULE.desc = "Implements a warrant system so staff can issue, view, and revoke warrants. Players are notified and all actions are logged with optional expirations."
MODULE.Features = {"Adds ability to issue and remove player warrants", "Adds notifications displayed to players", "Adds logging of all warrant actions", "Adds CAMI privileges for warrant management", "Adds timed expiration for warrants"}
MODULE.Privileges = {
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