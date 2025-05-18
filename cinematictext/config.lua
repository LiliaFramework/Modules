lia.config.add("CinematicTextFont", "Cinematic Text Font", "PoppinsMedium", nil, {
    desc = "The font used for cinematic text.",
    category = "Cinematic",
    type = "Generic"
})

lia.config.add("CinematicTextSize", "Cinematic Text Size", 18, nil, {
    desc = "The size of the standard cinematic text.",
    category = "Cinematic",
    type = "Int",
    min = 10,
    max = 100
})

lia.config.add("CinematicTextSizeBig", "Cinematic Big Text Size", 30, nil, {
    desc = "The size of the big cinematic text.",
    category = "Cinematic",
    type = "Int",
    min = 10,
    max = 100
})

lia.config.add("CinematicTextMusic", "Cinematic Text Music", "music/stingers/industrial_suspense2.wav", nil, {
    desc = "The music file played during cinematic text display.",
    category = "Cinematic",
    type = "Generic"
})
