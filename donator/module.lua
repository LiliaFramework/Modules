MODULE.name = "Donator"
MODULE.versionID = "public_donator"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.0
MODULE.desc = "Manages donor perks and extra character slots."
MODULE.Privileges = {
    ["subtractCharSlots"] = {
        Name = "subtractCharSlots",
        MinAccess = "superadmin",
        Category = "charSlots",
    },
    ["addCharSlots"] = {
        Name = "addCharSlots",
        MinAccess = "superadmin",
        Category = "charSlots",
    },
    ["setCharSlots"] = {
        Name = "setCharSlots",
        MinAccess = "superadmin",
        Category = "charSlots",
    }
}

MODULE.Changelog = {
    ["1.0"] = {"Initial Release"},
}
