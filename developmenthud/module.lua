MODULE.name = "Development HUD"
MODULE.uniqueID = "public_developmenthud"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.31
MODULE.desc = "Adds a staff-only development HUD, font customization via DevHudFont, a requirement for the CAMI privilege, real-time server performance metrics, and a toggle command to show or hide the HUD."
MODULE.Privileges = {
    {
        Name = "staffHUD",
        ID = "staffHUD",
        MinAccess = "superadmin",
        Category = "developmentHUD",
    },
    {
        Name = "developmentHUD",
        ID = "developmentHUD",
        MinAccess = "superadmin",
        Category = "developmentHUD",
    }
}