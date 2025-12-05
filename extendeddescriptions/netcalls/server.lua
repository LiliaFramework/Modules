net.Receive("EditDetailedDescriptions", function()
    local textEntryURL = net.ReadString()
    local text = net.ReadString()
    local callingClientSteamName = net.ReadString()
    for _, client in player.Iterator() do
        if client:SteamName() == callingClientSteamName then
            local char = client:getChar()
            char:setTextDetDescData(text)
            char:setTextDetDescDataURL(textEntryURL)
        end
    end
end)
