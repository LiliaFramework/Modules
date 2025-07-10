lia.config.add("DamageFont", "Damage Number Font", "PoppinsMedium", function()
    if not CLIENT then return end
    hook.Run("RefreshFonts")
end, {
    desc = "Specifies the font family used for floating damage numbers.",
    category = "Fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}
})

lia.option.add("damageNumberTime", "Damage Number Duration", "How long (in seconds) floating damage numbers stay on screen", 2, nil, {
    category = "HUD",
    min = 0.5,
    max = 5,
    decimals = 1,
    visible = true
})

lia.option.add("damageNumberAlpha", "Damage Number Alpha", "Base alpha for floating damage numbers", 125, nil, {
    category = "HUD",
    min = 0,
    max = 255,
    decimals = 0,
    visible = true
})
