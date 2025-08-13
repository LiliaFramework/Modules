lia.config.add("DamageFont", "damageNumberFont", "PoppinsMedium", function()
    if not CLIENT then return end
    hook.Run("RefreshFonts")
end, {
    desc = "damageNumberFontDesc",
    category = "fonts",
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