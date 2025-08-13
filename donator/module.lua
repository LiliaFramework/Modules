MODULE.name = "Donator"
MODULE.uniqueID = "public_donator"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.32
MODULE.desc = "Adds libraries to manage donor perks, tracking for donor ranks and perks, configurable perks by tier, and commands to adjust character slots."
MODULE.Features = {"Adds libraries to manage donor perks", "Adds tracking for donor ranks and perks", "Adds configurable perks by tier", "Adds commands to adjust character slots"}
MODULE.Privileges = {
    {
        Name = "subtractCharSlots",
        ID = "subtractCharSlots",
        MinAccess = "superadmin",
        Category = "charSlots",
    },
    {
        Name = "addCharSlots",
        ID = "addCharSlots",
        MinAccess = "superadmin",
        Category = "charSlots",
    },
    {
        Name = "setCharSlots",
        ID = "setCharSlots",
        MinAccess = "superadmin",
        Category = "charSlots",
    }
}