local restartTime = 0
net.Receive("RestartDisplay", function() restartTime = net.ReadInt(32) end)
function MODULE:HUDPaint()
    local remaining = restartTime - os.time()
    local interval = lia.config.get("RestartInterval")
    if remaining > 0 and remaining <= interval * 0.25 then
        local m = math.floor(remaining / 60)
        local s = remaining % 60
        draw.SimpleTextOutlined(L("restartCountdown", m, s), lia.config.get("RestartCountdownFont"), ScrW() - 10, 10, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0))
    end
end
