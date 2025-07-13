MODULE.name = "Warrant"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.12
MODULE.desc = "Allows staff to issue and remove player warrants while notifying everyone involved."
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

MODULE.Public = true
if SERVER then
    lia.log.addType("warrantIssue", function(client, target) return string.format("%s issued a warrant on %s", client:Name(), target:Name()) end, "Player")
    lia.log.addType("warrantRemove", function(client, target) return string.format("%s removed a warrant from %s", client:Name(), target:Name()) end, "Player")
end

MODULE.Features = {"Adds ability to issue and remove player warrants", "Adds notifications displayed to players", "Adds logging of all warrant actions", "Adds CAMI privileges for warrant management", "Adds timed expiration for warrants"}
