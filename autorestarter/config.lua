lia.config.add("RestartInterval", "Server restart interval (seconds)", 3600, function(_, newInterval)
    if CLIENT then return end
    MODULE.nextRestart = os.time() + newInterval
    net.Start("RestartDisplay")
    net.WriteInt(MODULE.nextRestart, 32)
    net.Broadcast()
end, {
    desc = "How often (in seconds) the server should auto-restart",
    category = "General",
    type = "Int",
    min = 60,
    max = 604800
})

lia.config.add("RestartCountdownFont", "Restart Countdown Font", "PoppinsMedium", nil, {
    desc = "Font used for the server restart countdown",
    category = "Fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}
})