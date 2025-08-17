MODULE.name = "NPC Spawner"
MODULE.uniqueID = "public_npcspawner"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.29
MODULE.desc = "Adds automatic NPC spawns at points, the ability for admins to force spawns, logging of spawn actions, and configuration for spawn intervals."
MODULE.Privileges = {
    {
        Name = "forceNPCSpawn",
        ID = "forceNPCSpawn",
        MinAccess = "superadmin",
        Category = "spawnPermissions",
    }
}