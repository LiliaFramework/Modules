MODULE.AFKAllowedPlayers = {"76561198312513285"}
lia.config.add("AFKWarningTime", "AFK Warning Time", 570, nil, {
    desc = "Time (in seconds) before the AFK warning is displayed.",
    category = "AFK Kicker",
    type = "Int",
    min = 10,
    max = 3600
})

lia.config.add("AFKTimerInterval", "AFK Timer Interval", 1, nil, {
    desc = "Interval (in seconds) for the AFK timer to check player activity.",
    category = "AFK Kicker",
    type = "Int",
    min = 1,
    max = 60
})

lia.config.add("AFKKickMessage", "AFK Kick Message", "Automatically kicked for being AFK for too long.", nil, {
    desc = "Message shown to players who are kicked for being AFK.",
    category = "AFK Kicker",
    type = "Generic"
})

lia.config.add("AFKWarningHead", "AFK Warning Header", "WARNING!", nil, {
    desc = "Header text displayed in the AFK warning.",
    category = "AFK Kicker",
    type = "Generic"
})

lia.config.add("AFKWarningTime", "AFK Warning Time", 570, nil, {
    desc = "Time (in seconds) before the AFK warning is displayed.",
    category = "AFK Kicker",
    type = "Int",
    min = 10,
    max = 3600
})

lia.config.add("AFKKickTime", "AFK Kick Time", 30, nil, {
    desc = "Time (in seconds) after the AFK warning is displayed before the player is kicked.",
    category = "AFK Kicker",
    type = "Int",
    min = 10,
    max = 3600
})

lia.config.add("AFKTimerInterval", "AFK Timer Interval", 1, nil, {
    desc = "Interval (in seconds) for the AFK timer to check player activity.",
    category = "AFK Kicker",
    type = "Int",
    min = 1,
    max = 60
})

lia.config.add("AFKKickMessage", "AFK Kick Message", "Automatically kicked for being AFK for too long.", nil, {
    desc = "Message shown to players who are kicked for being AFK.",
    category = "AFK Kicker",
    type = "Generic"
})

lia.config.add("AFKWarningSub", "AFK Warning Subtitle", "You are going to be sent back to the character menu/kicked for being AFK!\nPress any key to abort!", nil, {
    desc = "Subtitle text displayed in the AFK warning.",
    category = "AFK Kicker",
    type = "Generic"
})

lia.config.add("AFKKickTime", "AFK Kick Time", 30, nil, {
    desc = "Time (in seconds) after the AFK warning is displayed before the player is kicked.",
    category = "AFK Kicker",
    type = "Int",
    min = 10,
    max = 3600
})
