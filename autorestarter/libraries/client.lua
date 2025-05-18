local restartTime = 0
net.Receive("RestartDisplay", function() restartTime = net.ReadInt(32) end)
function MODULE:HUDPaint()
    local remaining = restartTime - os.time()
    if remaining > 0 then
        local mins = math.floor(remaining / 60)
        local secs = remaining % 60
        local txt = string.format("Server Restarting in: %02d:%02d", mins, secs)
        draw.SimpleTextOutlined(txt, lia.config.get("RestartCountdownFont"), ScrW() - 10, 10, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0))
    end
end