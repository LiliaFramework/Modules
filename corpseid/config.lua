lia.config.add("IdentificationTime", "identificationTime", 5, nil, {
    desc = "identificationTimeDesc",
    category = "identification",
    type = "Int",
    min = 1,
    max = 60
})

lia.config.add("CorpseMessageFont", "corpseMessageFont", "PoppinsMedium", function()
    if not CLIENT then return end
    hook.Run("RefreshFonts")
end, {
    desc = "corpseMessageFontDesc",
    category = "fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}
})
