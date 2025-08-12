MODULE.name = "Development HUD"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.25
MODULE.desc = "Adds a staff-only development HUD, font customization via DevHudFont, a requirement for the CAMI privilege, real-time server performance metrics, and a toggle command to show or hide the HUD."
MODULE.Privileges = {
    {
        Name = "staffHUD",
        ID = "staffHUD",
        MinAccess = "superadmin",
        Category = "Development HUD",
    },
    {
        Name = "developmentHUD",
        ID = "developmentHUD",
        MinAccess = "superadmin",
        Category = "Development HUD",
    }
}

MODULE.Public = true
MODULE.Features = {"Adds a staff-only development HUD", "Adds font customization via DevHudFont", "Adds a requirement for the CAMI privilege", "Adds real-time server performance metrics", "Adds a toggle command to show or hide the HUD"}