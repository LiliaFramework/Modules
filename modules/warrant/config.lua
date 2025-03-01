MODULE.CanSeeWarrants = {FACTION_KOPO}
MODULE.CanSeeWarrantsNotifications = {FACTION_KOPO}
lia.flag.add("P", "Adds Warrant Flag")
lia.config.add("RemoveWarrantOnDeath", "Remove Warrant On Death", true, nil, {
    desc = "Determines whether a warrant is removed from a player upon their death.",
    category = "Character",
    noNetworking = false,
    schemaOnly = false,
    isGlobal = false,
    type = "Boolean"
})
