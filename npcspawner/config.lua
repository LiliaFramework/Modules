MODULE.SpawnPositions = {
    ["rp_nycity_day"] = {
        ["City Center"] = {
            pos = Vector(-8768.493164, -3394.535400, 91.223183),
            radius = 250,
            maxNPCs = 5,
            maxPerType = {
                ["npc_citizen"] = 8,
                ["npc_combine_s"] = 4,
                ["npc_metropolice"] = 2
            }
        },
        ["Burgers"] = {
            pos = Vector(-10140.128906, -2080.388428, 90.029953),
            radius = 150,
            maxNPCs = 5,
            maxPerType = {
                ["npc_citizen"] = 5,
                ["npc_combine_s"] = 2,
                ["npc_zombie"] = 3
            }
        },
    }
}

lia.config.add("SpawnCooldown", "Spawn Cooldown", 240, function(newValue)
    if timer.Exists("NPCSpawnTimer") then timer.Remove("NPCSpawnTimer") end
    timer.Create("NPCSpawnTimer", newValue, 0, spawnCycle)
end, {
    desc = "Sets the cooldown time (in seconds) between spawns.",
    category = "Spawning",
    type = "Int",
    min = 1,
    max = 3600
})
