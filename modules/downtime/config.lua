lia.config.add("RPMinimumPlayerCount", "Minimum Player Count for RP", 5, nil, {
    desc = "Minimum number of players required to consider the server as active for roleplay.",
    category = "Server",
    type = "Int",
    min = 1,
    max = 100
})

lia.config.add("EnableDownTime", "Enable Downtime Detection", false, nil, {
    desc = "Enables or disables the downtime detection based on player count.",
    category = "Server",
    type = "Boolean"
})
