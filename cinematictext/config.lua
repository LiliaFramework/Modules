lia.config.add("CinematicTextFont", "cinematicTextFont", "PoppinsMedium", nil, {
    desc = "cinematicTextFontDesc",
    category = "cinematic",
    type = "Generic"
})

lia.config.add("CinematicTextSize", "cinematicTextSize", 18, nil, {
    desc = "cinematicTextSizeDesc",
    category = "cinematic",
    type = "Int",
    min = 10,
    max = 100
})

lia.config.add("CinematicTextSizeBig", "cinematicBigTextSize", 30, nil, {
    desc = "cinematicBigTextSizeDesc",
    category = "cinematic",
    type = "Int",
    min = 10,
    max = 100
})

lia.config.add("CinematicTextMusic", "cinematicTextMusic", "music/stingers/industrial_suspense2.wav", nil, {
    desc = "cinematicTextMusicDesc",
    category = "cinematic",
    type = "Generic"
})