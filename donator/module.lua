MODULE.name = "Donator"
MODULE.versionID = "public_donator"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.34
MODULE.desc = "Adds libraries to manage donor perks, tracking for donor ranks and perks, configurable perks by tier, and commands to adjust character slots."
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