MODULE.name = "moduleLoyalismName"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.22
MODULE.Public = true
MODULE.desc = "moduleLoyalismDesc"
MODULE.Features = {"Adds a loyalty tier system for players", "Adds the /partytier command access", "Adds permission control through flags", "Adds automatic tier progression", "Adds customizable rewards per tier"}
lia.flag.add("T", "Access to /partytier")
MODULE.Privileges = {
    {
        Name = "managementAssignPartyTiers",
        ID = "managementAssignPartyTiers",
        MinAccess = "admin",
        Category = "Loyalism",
    }
}