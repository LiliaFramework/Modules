lia.config.add("AFKTime", "AFK Time", 180, nil, {
    desc = "Time in seconds before a player is considered AFK",
    category = "AFK Protection",
    type = "Int",
    min = 30,
    max = 600
})

lia.config.add("AFKProtectionEnabled", "AFK Protection Enabled", true, nil, {
    desc = "Enable or disable AFK protection system",
    category = "AFK Protection",
    type = "Boolean"
})