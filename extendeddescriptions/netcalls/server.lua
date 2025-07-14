net.Receive("EditDetailedDescriptions", function()
    local textEntryURL = net.ReadString()
    local text = net.ReadString()
    local callingClientSteamName = net.ReadString()
    for _, client in player.Iterator() do
        if client:SteamName() == callingClientSteamName then
            client:getChar():setData("textDetDescData", text)
            client:getChar():setData("textDetDescDataURL", textEntryURL)
            hook.Run("ExtendedDescriptionUpdated", client, textEntryURL, text)
        end
    end
end)

local networkStrings = {"OpenDetailedDescriptions", "SetDetailedDescriptions", "EditDetailedDescriptions"}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
