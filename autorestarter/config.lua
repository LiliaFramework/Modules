lia.config.add("RestartInterval", "serverRestartIntervalSeconds", 3600, function(_, newInterval)
    if CLIENT then return end
    MODULE.nextRestart = os.time() + newInterval
    net.Start("RestartDisplay")
    net.WriteInt(MODULE.nextRestart, 32)
    net.Broadcast()
end, {
    desc = "serverRestartIntervalSecondsDesc",
    category = "general",
    type = "Int",
    min = 60,
    max = 604800
})

lia.config.add("RestartCountdownFont", "restartCountdownFont", "Montserrat Medium", nil, {
    desc = "restartCountdownFontDesc",
    category = "fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"Montserrat Medium"}
})
