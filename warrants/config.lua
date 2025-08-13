MODULE.CanSeeWarrants = {FACTION_KOPO}
MODULE.CanSeeWarrantsNotifications = {FACTION_KOPO}
lia.flag.add("P", "Adds Warrant Flag")
lia.config.add("RemoveWarrantOnDeath", "removeWarrantOnDeath", true, nil, {
    desc = "removeWarrantOnDeathDesc",
    category = "character",
    noNetworking = false,
    schemaOnly = false,
    isGlobal = false,
    type = "Boolean"
})