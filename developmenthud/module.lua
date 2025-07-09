MODULE.name = "Development HUD"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.5"
MODULE.desc = "Adds a Development HUD"
MODULE.CAMIPrivileges = {

    {
        Name = "Staff Permissions - Staff HUD",
        MinAccess = "superadmin",
    },
    {
        Name = "Staff Permissions - Development HUD",
        MinAccess = "superadmin",
    }
}

lia.config.add("DevHudFont", "Development HUD Font", "PoppinsMedium", function()
    if not CLIENT then return end
    hook.Run("RefreshFonts")
end, {
    desc = "Font used for all development/staff HUD text",
    category = "Fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}})
MODULE.Public = true
