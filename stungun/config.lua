lia.config.add("StunTime", "stunTime", 4, nil, {
    desc = "stunTimeDesc",
    category = "weapon",
    type = "Float",
    min = 0,
    max = 30,
    decimals = 2
})

lia.config.add("MaxDist", "taserMaxDistance", 400, nil, {
    desc = "taserMaxDistanceDesc",
    category = "weapon",
    type = "Int",
    min = 0,
    max = 2000
})

lia.config.add("DrawPostProcess", "enableStunPostProcessing", true, nil, {
    desc = "enableStunPostProcessingDesc",
    category = "visuals",
    type = "Boolean"
})

lia.config.add("Damage", "overStunDamage", 5, nil, {
    desc = "overStunDamageDesc",
    category = "weapon",
    type = "Int",
    min = 0,
    max = 100
})