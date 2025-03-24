lia.config.add( "FlashlightEnabled", "Enable Flashlight", true, nil, {
	desc = "Enables or disables the flashlight functionality.",
	category = "Flashlight",
	type = "Boolean"
} )

lia.config.add( "FlashlightNeedsItem", "Flashlight Requires Item", true, nil, {
	desc = "Determines if a specific item is required to use the flashlight.",
	category = "Flashlight",
	type = "Boolean"
} )

lia.config.add( "FlashlightCooldown", "Flashlight Cooldown", 0.5, nil, {
	desc = "Sets the cooldown time (in seconds) between flashlight toggles.",
	category = "Flashlight",
	type = "Float",
	min = 0,
	max = 10
} )
