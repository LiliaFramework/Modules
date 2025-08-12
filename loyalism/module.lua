MODULE.name = "Loyalism"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.23
MODULE.desc = "Adds a loyalty tier system for players, the /partytier command access, permission control through flags, automatic tier progression, and customizable rewards per tier."
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