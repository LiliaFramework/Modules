MODULE.name = "Radio"
MODULE.author = "76561198312513285"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.7"
MODULE.desc = "Radio"
MODULE.WorkshopContent = "3431349806"
MODULE.Public = true
lia.config.add("RadioFont", "Radio Font", "Lucida Console", nil, {
    desc = "Specifies the font used for radio-related text and displays.",
    category = "Visuals",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"Lucida Console"}
})