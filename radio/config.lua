lia.config.add("RadioChatColor", "radioChatColor", {
    r = 100,
    g = 255,
    b = 50
}, nil, {
    desc = "radioChatColorDesc",
    category = "visuals",
    noNetworking = false,
    schemaOnly = false,
    isGlobal = true,
    type = "Color"
})

lia.config.add("RadioFont", "radioFont", "PoppinsMedium", function()
    if not CLIENT then return end
    hook.Run("RefreshFonts")
end, {
    desc = "radioFontDesc",
    category = "fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}
})