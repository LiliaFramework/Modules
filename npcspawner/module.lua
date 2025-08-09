MODULE.name = "moduleNpcSpawnerName"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.20
MODULE.desc = "moduleNpcSpawnerDesc"
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
        Category = "Spawn Permissions",
    }
}