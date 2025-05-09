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

lia.option.add("FPSDraw", "FPS Draw", "Enable FPS display on the HUD", false, nil, {
    category = "HUD",
})