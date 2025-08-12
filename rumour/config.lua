lia.config.add("RumourCooldown", "Rumor Cooldown", 60, nil, {
    desc = "Sets the cooldown time for rumors (in seconds).",
    category = "Gameplay",
    type = "Int",
    min = 0,
    max = 3600
})

lia.config.add("RumourRevealChance", "Rumour Reveal Chance", 0.02, nil, {
    desc = "The chance for a rumour to reveal the criminal's identity (default 2%).",
    category = "Gameplay",
    type = "Float",
    min = 0,
    max = 1
})