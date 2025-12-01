lia.config.add("RumourCooldown", "rumorCooldown", 60, nil, {
    desc = "rumorCooldownDesc",
    category = "gameplay",
    type = "Int",
    min = 0,
    max = 3600
})

lia.config.add("RumourRevealChance", "rumourRevealChance", 0.02, nil, {
    desc = "rumourRevealChanceDesc",
    category = "gameplay",
    type = "Float",
    min = 0,
    max = 1
})
