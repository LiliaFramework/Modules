MODULE.name = "Donator"
MODULE.uniqueID = "public_donator"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.31
MODULE.desc = "Adds libraries to manage donor perks, tracking for donor ranks and perks, configurable perks by tier, and commands to adjust character slots."
MODULE.Features = {"Adds libraries to manage donor perks", "Adds tracking for donor ranks and perks", "Adds configurable perks by tier", "Adds commands to adjust character slots"}
MODULE.Privileges = {
    {
        Name = "subtractCharSlots",
        ID = "Subtract CharSlots",
        MinAccess = "superadmin",
        Category = "Character Slots",
    },
    {
        Name = "addCharSlots",
        ID = "Add CharSlots",
        MinAccess = "superadmin",
        Category = "Character Slots",
    },
    {
        Name = "setCharSlots",
        ID = "Set CharSlots",
        MinAccess = "superadmin",
        Category = "Character Slots",
    }
}