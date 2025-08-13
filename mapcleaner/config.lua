MODULE.MapCleanerEntitiesToRemove = {"lia_item", "prop_physics"}
lia.config.add("MapCleanerEnabled", "enableMapCleaner", true, nil, {
    desc = "enableMapCleanerDesc",
    category = "cleanup",
    type = "Boolean"
})

lia.config.add("ItemCleanupTime", "itemCleanupTime", 7200, nil, {
    desc = "itemCleanupTimeDesc",
    category = "cleanup",
    type = "Int",
    min = 60,
    max = 86400
})

lia.config.add("MapCleanupTime", "mapCleanupTime", 21600, nil, {
    desc = "mapCleanupTimeDesc",
    category = "cleanup",
    type = "Int",
    min = 3600,
    max = 86400
})