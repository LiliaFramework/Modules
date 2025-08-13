lia.config.add("FlashlightEnabled", "enableFlashlight", true, nil, {
    desc = "enableFlashlightDesc",
    category = "flashlight",
    type = "Boolean"
})

lia.config.add("FlashlightNeedsItem", "flashlightRequiresItem", true, nil, {
    desc = "flashlightRequiresItemDesc",
    category = "flashlight",
    type = "Boolean"
})

lia.config.add("FlashlightCooldown", "flashlightCooldown", 0.5, nil, {
    desc = "flashlightCooldownDesc",
    category = "flashlight",
    type = "Float",
    min = 0,
    max = 10
})