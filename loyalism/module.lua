MODULE.name = "Loyalism"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.19
MODULE.Public = true
MODULE.desc = "Tracks player loyalty tiers which unlock the /partytier command and other rewards. Tiers can progress automatically based on actions."
MODULE.Features = {"Adds a loyalty tier system for players", "Adds the /partytier command access", "Adds permission control through flags", "Adds automatic tier progression", "Adds customizable rewards per tier"}
lia.flag.add("T", "Access to /partytier")
MODULE.Privileges = {
    {
        Name = "Management - Assign Party Tiers",
        MinAccess = "admin",
    }
}