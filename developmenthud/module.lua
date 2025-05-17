MODULE.name = "Development HUD"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.3"
MODULE.desc = "Adds a Development HUD"
MODULE.Public = true
MODULE.CAMIPrivileges = {
    {
        Name = "Staff Permissions - Staff HUD",
        MinAccess = "superadmin",
        Description = "Allows access to Staff HUD.",
    },
    {
        Name = "Staff Permissions - Development HUD",
        MinAccess = "superadmin",
        Description = "Allows access to Development HUD.",
    }
}

lia.config.add("DevHudFont", "Development HUD Font", "Arial", nil, {
    desc = "Font used for all development/staff HUD text",
    category = "Fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"Arial"}
})