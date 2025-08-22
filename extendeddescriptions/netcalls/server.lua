net.Receive("EditDetailedDescriptions", function()
    local textEntryURL = net.ReadString()
    local text = net.ReadString()
    local callingClientSteamName = net.ReadString()
    for _, client in player.Iterator() do
        if client:SteamName() == callingClientSteamName then
            hook.Run("PreExtendedDescriptionUpdate", client, textEntryURL, text)
            local char = client:getChar()
            char:setTextDetDescData(text)
            char:setTextDetDescDataURL(textEntryURL)
            hook.Run("ExtendedDescriptionUpdated", client, textEntryURL, text)
        end
    end
end)

