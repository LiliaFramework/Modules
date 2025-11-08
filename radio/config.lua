
lia.config.add("RadioFont", "radioFont", "Montserrat Medium", function()
    if not CLIENT then return end
    hook.Run("RefreshFonts")
end, {
    desc = "radioFontDesc",
    category = "fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"Montserrat Medium"}
})
