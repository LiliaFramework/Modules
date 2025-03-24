lia.config.add( "AlcoholTickTime", "Alcohol Tick Time", 30, nil, {
	desc = "Time interval (in seconds) for alcohol degradation.",
	category = "Alcoholism",
	type = "Int",
	min = 1,
	max = 300
} )

lia.config.add( "AlcoholDegradeRate", "Alcohol Degrade Rate", 5, nil, {
	desc = "Rate at which alcohol BAC decreases per tick.",
	category = "Alcoholism",
	type = "Int",
	min = 1,
	max = 100
} )

lia.config.add( "AlcoholAddAlpha", "Alcohol Alpha Effect", 0.03, nil, {
	desc = "Alpha value added for visual effects when drunk.",
	category = "Alcoholism",
	type = "Float",
	min = 0.01,
	max = 1
} )

lia.config.add( "AlcoholEffectDelay", "Alcohol Effect Delay", 0.03, nil, {
	desc = "Delay between applying drunk effects (in seconds).",
	category = "Alcoholism",
	type = "Float",
	min = 0.01,
	max = 1
} )

lia.config.add( "DrunkNotifyThreshold", "Drunk Notification Threshold", 50, nil, {
	desc = "BAC level at which the player receives drunk notifications.",
	category = "Alcoholism",
	type = "Int",
	min = 1,
	max = 100
} )

lia.config.add( "AlcoholMotionBlurAlpha", "Alcohol Motion Blur Alpha", 0.03, nil, {
	desc = "Alpha value for motion blur when intoxicated.",
	category = "Alcoholism",
	type = "Float",
	min = 0.01,
	max = 1
} )

lia.config.add( "AlcoholMotionBlurDelay", "Alcohol Motion Blur Delay", 0.03, nil, {
	desc = "Delay for motion blur effects when intoxicated.",
	category = "Alcoholism",
	type = "Float",
	min = 0.01,
	max = 1
} )
