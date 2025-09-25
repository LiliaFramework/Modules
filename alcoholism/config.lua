MODULE.AlcoholItems = {
    vodka_bottle = {
        name = "Vodka",
        model = "models/props_junk/glassjug01.mdl",
        abv = 40,
        weight = 0.8,
        price = 45,
        category = "Alcohol",
        width = 1,
        height = 2
    },
    whiskey_bottle = {
        name = "Whiskey",
        model = "models/props_junk/garbage_glassbottle003a.mdl",
        abv = 43,
        weight = 0.9,
        price = 60,
        category = "Alcohol",
        width = 1,
        height = 2
    },
    red_wine = {
        name = "Red Wine",
        model = "models/props_junk/garbage_glassbottle002a.mdl",
        abv = 13,
        weight = 1.1,
        price = 35,
        category = "Alcohol",
        width = 1,
        height = 2
    },
    white_wine = {
        name = "White Wine",
        model = "models/props_junk/garbage_glassbottle001a.mdl",
        abv = 12,
        weight = 1.1,
        price = 33,
        category = "Alcohol",
        width = 1,
        height = 2
    },
    lager_can = {
        name = "Lager",
        model = "models/props_junk/popcan01a.mdl",
        abv = 5,
        weight = 0.2,
        price = 6,
        category = "Alcohol",
        width = 1,
        height = 1
    },
    stout_bottle = {
        name = "Stout",
        model = "models/props_junk/garbage_glassbottle003a.mdl",
        abv = 6,
        weight = 0.3,
        price = 7,
        category = "Alcohol",
        width = 1,
        height = 1
    },
    rum_bottle = {
        name = "Rum",
        model = "models/props_junk/glassjug01.mdl",
        abv = 37,
        weight = 0.85,
        price = 50,
        category = "Alcohol",
        width = 1,
        height = 2
    },
    gin_bottle = {
        name = "Gin",
        model = "models/props_junk/garbage_glassbottle003a.mdl",
        abv = 41,
        weight = 0.8,
        price = 48,
        category = "Alcohol",
        width = 1,
        height = 2
    },
    tequila_bottle = {
        name = "Tequila",
        model = "models/props_junk/glassjug01.mdl",
        abv = 38,
        weight = 0.85,
        price = 52,
        category = "Alcohol",
        width = 1,
        height = 2
    },
    cider_bottle = {
        name = "Cider",
        model = "models/props_junk/garbage_glassbottle002a.mdl",
        abv = 4,
        weight = 0.35,
        price = 8,
        category = "Alcohol",
        width = 1,
        height = 1
    },
    mead_flask = {
        name = "Mead",
        model = "models/props_junk/garbage_glassbottle001a.mdl",
        abv = 10,
        weight = 0.6,
        price = 22,
        category = "Alcohol",
        width = 1,
        height = 1
    },
    moonshine_jar = {
        name = "Moonshine",
        model = "models/props_lab/jar01b.mdl",
        abv = 60,
        weight = 0.7,
        price = 75,
        category = "Alcohol",
        width = 1,
        height = 1
    },
    absinthe_bottle = {
        name = "Absinthe",
        model = "models/props_junk/garbage_glassbottle003a.mdl",
        abv = 68,
        weight = 0.8,
        price = 95,
        category = "Alcohol",
        width = 1,
        height = 2
    },
    sake_bottle = {
        name = "Sake",
        model = "models/props_junk/glassjug01.mdl",
        abv = 15,
        weight = 0.7,
        price = 28,
        category = "Alcohol",
        width = 1,
        height = 2
    },
    soju_bottle = {
        name = "Soju",
        model = "models/props_junk/garbage_glassbottle001a.mdl",
        abv = 19,
        weight = 0.55,
        price = 18,
        category = "Alcohol",
        width = 1,
        height = 1
    }
}

lia.config.add("AlcoholTickTime", "alcoholTickTime", 30, nil, {
    desc = "alcoholTickTimeDesc",
    category = "alcoholism",
    type = "Int",
    min = 1,
    max = 300
})

lia.config.add("AlcoholDegradeRate", "alcoholDegradeRate", 5, nil, {
    desc = "alcoholDegradeRateDesc",
    category = "alcoholism",
    type = "Int",
    min = 1,
    max = 100
})

lia.config.add("AlcoholAddAlpha", "alcoholAlphaEffect", 0.03, nil, {
    desc = "alcoholAlphaEffectDesc",
    category = "alcoholism",
    type = "Float",
    min = 0.01,
    max = 1
})

lia.config.add("AlcoholEffectDelay", "alcoholEffectDelay", 0.03, nil, {
    desc = "alcoholEffectDelayDesc",
    category = "alcoholism",
    type = "Float",
    min = 0.01,
    max = 1
})

lia.config.add("DrunkNotifyThreshold", "drunkNotificationThreshold", 50, nil, {
    desc = "drunkNotificationThresholdDesc",
    category = "alcoholism",
    type = "Int",
    min = 1,
    max = 100
})

lia.config.add("AlcoholMotionBlurAlpha", "alcoholMotionBlurAlpha", 0.03, nil, {
    desc = "alcoholMotionBlurAlphaDesc",
    category = "alcoholism",
    type = "Float",
    min = 0.01,
    max = 1
})

lia.config.add("AlcoholMotionBlurDelay", "alcoholMotionBlurDelay", 0.03, nil, {
    desc = "alcoholMotionBlurDelayDesc",
    category = "alcoholism",
    type = "Float",
    min = 0.01,
    max = 1
})

lia.config.add("AlcoholIntenseMultiplier", "alcoholIntenseMultiplier", 2, nil, {
    desc = "alcoholIntenseMultiplierDesc",
    category = "alcoholism",
    type = "Float",
    min = 1,
    max = 5
})

lia.config.add("AlcoholRagdollThreshold", "alcoholRagdollThreshold", 80, nil, {
    desc = "alcoholRagdollThresholdDesc",
    category = "alcoholism",
    type = "Int",
    min = 1,
    max = 100
})

lia.config.add("AlcoholRagdollMin", "alcoholRagdollMin", 10, nil, {
    desc = "alcoholRagdollMinDesc",
    category = "alcoholism",
    type = "Int",
    min = 1,
    max = 600
})

lia.config.add("AlcoholRagdollMax", "alcoholRagdollMax", 15, nil, {
    desc = "alcoholRagdollMaxDesc",
    category = "alcoholism",
    type = "Int",
    min = 1,
    max = 600
})

lia.config.add("AlcoholRagdollChance", "alcoholRagdollChance", 5, nil, {
    desc = "alcoholRagdollChanceDesc",
    category = "alcoholism",
    type = "Int",
    min = 1,
    max = 100
})

lia.config.add("AlcoholRagdollDuration", "alcoholRagdollDuration", 5, nil, {
    desc = "alcoholRagdollDurationDesc",
    category = "alcoholism",
    type = "Int",
    min = 1,
    max = 60
})

lia.config.add("AlcoholIntenseTime", "alcoholIntenseTime", 5, nil, {
    desc = "alcoholIntenseTimeDesc",
    category = "alcoholism",
    type = "Int",
    min = 1,
    max = 60
})
