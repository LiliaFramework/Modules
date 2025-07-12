MODULE.name = "Development HUD"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.7"
MODULE.desc = "Provides a staff-only HUD overlay with additional development information."
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

MODULE.Public = true
lia.config.add("DevHudFont", "Development HUD Font", "PoppinsMedium", function()
    if not CLIENT then return end
    hook.Run("RefreshFonts")
end, {
    desc = "Font used for all development/staff HUD text",
    category = "Fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}
})

MODULE.Features = {"Adds a staff-only development HUD", "Adds font customization via DevHudFont", "Adds a requirement for the CAMI privilege", "Adds real-time server performance metrics", "Adds a toggle command to show or hide the HUD",}
