lia.config.add("WatermarkEnabled", "Enable Watermark", false, nil, {
    desc = "Enables the watermark display",
    category = "Visuals",
    type = "Boolean"
})

lia.config.add("WatermarkLogo", "Watermark Logo Path", "", nil, {
    desc = "The path to the watermark image (PNG)",
    category = "Visuals",
    type = "Generic"
})

lia.config.add("GamemodeVersion", "Gamemode Version", "", nil, {
    desc = "The version of the gamemode",
    category = "Visuals",
    type = "Generic"
})

lia.config.add("Vignette", "Enable Vignette Effect", true, nil, {
    desc = "Enables the vignette effect",
    category = "Visuals",
    type = "Boolean"
})

lia.config.add("FPSHudFont", "FPS HUD Font", "PoppinsMedium", function()
    if not CLIENT then return end
    hook.Run("RefreshFonts")
end, {
    desc = "Font used for the FPS display",
    category = "Fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}
})

lia.option.add("FPSDraw", "FPS Draw", "Enable FPS display on the HUD", false, nil, {
    category = "HUD",
})