net.Receive("RumorMessageCall", function()
    local rumourMessage = net.ReadString()
    chat.AddText(L("rumourMessagePrefix", rumourMessage))
end)
