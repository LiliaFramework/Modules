if CLIENT then
	lia.option.add( "freelookEnabled", "Enable Freelook", "Enable or disable the freelook functionality.", false, nil, {
		category = "View",
		type = "Boolean",
		IsQuick = true
	} )

	lia.option.add( "freelookLimitVertical", "Freelook Vertical Limit", "Set the maximum freelook angle vertically.", 65, nil, {
		category = "View",
		type = "Int",
		min = 30,
		max = 90,
		IsQuick = false
	} )

	lia.option.add( "freelookLimitHorizontal", "Freelook Horizontal Limit", "Set the maximum freelook angle horizontally.", 90, nil, {
		category = "View",
		type = "Int",
		min = 60,
		max = 120,
		IsQuick = false
	} )

	lia.option.add( "freelookSmoothness", "Freelook Smoothness", "Set the smoothness of the freelook movement.", 1, nil, {
		category = "View",
		type = "Float",
		min = 0.1,
		max = 2,
		decimals = 2,
		IsQuick = false
	} )

	lia.option.add( "freelookBlockADS", "Freelook Block ADS", "Prevent freelook while aiming down sights.", true, nil, {
		category = "View",
		type = "Boolean",
		IsQuick = false
	} )
end
