MODULE.SpawnPositions = {
    --[[
    ["gm_construct"] = {
        {
            ent = "npc_zombie",
            pos = Vector(5229.57, 4160.89, 64.03)
        },
        {
            ent = "npc_zombie",
            pos = Vector(5300.00, 4200.00, 64.03)
        },
        {
            ent = "npc_zombie",
            pos = Vector(5400.00, 4300.00, 64.03)
        },
        {
            ent = "npc_zombie",
            pos = Vector(5500.00, 4400.00, 64.03)
        },
        {
            ent = "npc_zombie",
            pos = Vector(5600.00, 4500.00, 64.03)
        },
        {
            ent = "npc_zombie",
            pos = Vector(5700.00, 4600.00, 64.03)
        },
        {
            ent = "npc_zombie",
            pos = Vector(5800.00, 4700.00, 64.03)
        },
        {
            ent = "npc_zombie",
            pos = Vector(5900.00, 4800.00, 64.03)
        },
    }
    ]]
}

lia.config.add("SpawnRadius", "Spawn Radius", 2000, nil, {
    desc = "Sets the radius (in units) within which spawns occur.",
    category = "Spawning",
    type = "Int",
    min = 100,
    max = 10000
})

lia.config.add("SpawnCooldown", "Spawn Cooldown", 240, nil, {
    desc = "Sets the cooldown time (in seconds) between spawns.",
    category = "Spawning",
    type = "Int",
    min = 1,
    max = 3600
})