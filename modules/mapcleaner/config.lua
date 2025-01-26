MODULE.MapCleanerEntitiesToRemove = {"lia_item", "prop_physics"}
lia.config.add("MapCleanerEnabled", "Enable Map Cleaner", true, nil, {
    desc = "Enables or disables the automatic map cleaner.",
    category = "Cleanup",
    type = "Boolean"
})

lia.config.add("ItemCleanupTime", "Item Cleanup Time", 7200, nil, {
    desc = "Time interval (in seconds) for item cleanup.",
    category = "Cleanup",
    type = "Int",
    min = 60,
    max = 86400
})

lia.config.add("MapCleanupTime", "Map Cleanup Time", 21600, nil, {
    desc = "Time interval (in seconds) for map cleanup.",
    category = "Cleanup",
    type = "Int",
    min = 3600,
    max = 86400
})
