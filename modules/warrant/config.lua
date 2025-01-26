MODULE.CanSeeWarrants = {FACTION_STAFF}
MODULE.CanSeeWarrantsNotifications = {FACTION_STAFF}
lia.flag.add("P", "Adds Warrant Flag")
lia.config.add("RemoveWarrantOnDeath", "Remove Warrant On Death", true, nil, {
    desc = "Determines whether a warrant is removed from a player upon their death.",
    category = "Character",
    noNetworking = false,
    schemaOnly = false,
    isGlobal = false,
    type = "Boolean"
})
