net.Receive("RumorMessageCall", function()
    local rumourMessage = net.ReadString()
    chat.AddText(Color(0, 0, 0), "[Rumour]: ", Color(255, 255, 255), rumourMessage)
end)