﻿lia.config.add("WatermarkEnabled", "enableWatermark", false, nil, {
    desc = "enableWatermarkDesc",
    category = "visuals",
    type = "Boolean"
})

lia.config.add("WatermarkLogo", "watermarkLogoPath", "", nil, {
    desc = "watermarkLogoPathDesc",
    category = "visuals",
    type = "Generic"
})

lia.config.add("GamemodeVersion", "gamemodeVersion", "", nil, {
    desc = "gamemodeVersionDesc",
    category = "visuals",
    type = "Generic"
})

lia.config.add("Vignette", "enableVignetteEffect", true, nil, {
    desc = "enableVignetteEffectDesc",
    category = "visuals",
    type = "Boolean"
})

lia.config.add("FPSHudFont", "fpsHudFont", "PoppinsMedium", function()
    if not CLIENT then return end
    hook.Run("RefreshFonts")
end, {
    desc = "fpsHudFontDesc",
    category = "fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}
})

lia.option.add("FPSDraw", "FPS Draw", "Enable FPS display on the HUD", false, nil, {
    category = "HUD",
})