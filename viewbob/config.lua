lia.option.add("viewbobEnable", "Enable ViewBob", "Enable or disable the viewbob effect.", false, nil, {
    category = "ViewBob",
    type = "Boolean",
    IsQuick = true
})

lia.option.add("viewbobMultiplierWalk", "ViewBob Walk Multiplier", "Adjust the viewbob effect multiplier for walking.", 0.25, nil, {
    category = "ViewBob",
    type = "Float",
    min = 0.1,
    max = 0.5,
    decimals = 2,
    IsQuick = true
})

lia.option.add("viewbobMultiplierCrouch", "ViewBob Crouch Multiplier", "Adjust the viewbob effect multiplier for crouching.", 0.1, nil, {
    category = "ViewBob",
    type = "Float",
    min = 0.05,
    max = 0.3,
    decimals = 2,
    IsQuick = true
})

lia.option.add("viewbobMultiplierSprint", "ViewBob Sprint Multiplier", "Adjust the viewbob effect multiplier for sprinting.", 0.4, nil, {
    category = "ViewBob",
    type = "Float",
    min = 0.2,
    max = 0.7,
    decimals = 2,
    IsQuick = true
})