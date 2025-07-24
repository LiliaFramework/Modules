MODULE.name = "Development HUD"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.19
MODULE.desc = "Shows a staff-only HUD with live performance metrics and other development data. Access requires a CAMI privilege and can be toggled as needed."
MODULE.Privileges = {
    {
        Name = "Staff HUD",
        MinAccess = "superadmin",
    },
    {
        Name = "Development HUD",
        MinAccess = "superadmin",
    }
}

MODULE.Public = true
MODULE.Features = {"Adds a staff-only development HUD", "Adds font customization via DevHudFont", "Adds a requirement for the CAMI privilege", "Adds real-time server performance metrics", "Adds a toggle command to show or hide the HUD"}
