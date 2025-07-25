MODULE.name = "NPC Spawner"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.18
MODULE.desc = "Spawns NPCs at preset points on a schedule. Staff can force spawns manually and all actions are logged."
MODULE.Public = true
MODULE.Features = {
    "Adds automatic NPC spawns at points",
    "Adds the ability for admins to force spawns",
    "Adds logging of spawn actions",
    "Adds configuration for spawn intervals"
}
MODULE.Privileges = {
    {
        Name = "Force NPC Spawn",
        MinAccess = "superadmin",
    }
}