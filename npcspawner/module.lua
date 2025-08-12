MODULE.name = "NPC Spawner"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.24
MODULE.desc = "Adds automatic NPC spawns at points, the ability for admins to force spawns, logging of spawn actions, and configuration for spawn intervals."
MODULE.Features = {"Adds automatic NPC spawns at points", "Adds the ability for admins to force spawns", "Adds logging of spawn actions", "Adds configuration for spawn intervals"}
MODULE.Privileges = {
    {
        Name = "forceNPCSpawn",
        ID = "forceNPCSpawn",
        MinAccess = "superadmin",
        Category = "Spawn Permissions",
    }
}