lia.config.add("RadioChatColor", "Radio Chat Color", {
    r = 100,
    g = 255,
    b = 50
}, nil, {
    desc = "Sets the color used for radio chat messages.",
    category = "Visuals",
    noNetworking = false,
    schemaOnly = false,
    isGlobal = true,
    type = "Color"
})

lia.config.add("RadioFont", "Radio Font", "PoppinsMedium", function()
    if not CLIENT then return end
    hook.Run("RefreshFonts")
end, {
    desc = "Specifies the font used for radio-related text and displays.",
    category = "Fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}
})