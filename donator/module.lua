MODULE.name = "Donator Perks"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.25
MODULE.desc = "Provides libraries to manage donor ranks and perks. Perks can be configured per tier and players may receive extra character slots."
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
    },
    {
        Name = "Add CharSlots",
        MinAccess = "superadmin",
    },
    {
        Name = "Set CharSlots",
        MinAccess = "superadmin",
    }
}
