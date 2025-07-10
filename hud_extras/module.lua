MODULE.name = "Extra HUD Elements"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.6"
MODULE.desc = "Implements Extra HUD Elements."
MODULE.Public = true

lia.config.add("FPSHudFont", "FPS HUD Font", "PoppinsMedium", function() if not CLIENT then return end hook.Run("RefreshFonts") end, {
    desc = "Font used for the FPS display",
    category = "Fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}})
MODULE.Features = {
    "Adds extra HUD elements like an FPS counter",
    "Adds fonts configurable with FPSHudFont",
    "Adds hooks so other modules can extend",
}
