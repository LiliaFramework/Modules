MODULE.name = "moduleDonatorName"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.28
MODULE.desc = "moduleDonatorDesc"
MODULE.Public = true
MODULE.Features = {
    "Adds libraries to manage donor perks",
    "Adds tracking for donor ranks and perks",
    "Adds configurable perks by tier",
    "Adds commands to adjust character slots"
}
MODULE.Privileges = {
    {
        Name = "Subtract CharSlots",
        MinAccess = "superadmin",
        Category = "Character Slots",
    },
    {
        Name = "Add CharSlots",
        MinAccess = "superadmin",
        Category = "Character Slots",
    },
    {
        Name = "Set CharSlots",
        MinAccess = "superadmin",
        Category = "Character Slots",
    }
}
