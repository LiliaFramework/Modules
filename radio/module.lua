MODULE.name = "Radio"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.9"
MODULE.desc = "Radio"
MODULE.WorkshopContent = "3431349806"
MODULE.Public = true

lia.config.add("RadioFont", "Radio Font", "PoppinsMedium", function() if not CLIENT then return end hook.Run("RefreshFonts") end, {
    desc = "Specifies the font used for radio-related text and displays.",
    category = "Fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}})
MODULE.Features = {}
