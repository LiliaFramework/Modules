lia.config.add("DevHudFont", "developmentHudFont", "Montserrat Medium", function()
    if not CLIENT then return end
end, {
    desc = "developmentHudFontDesc",
    category = "fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"Montserrat Medium"}
})
