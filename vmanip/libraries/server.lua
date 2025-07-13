function MODULE:OnPlayerInteractItem(client, action, item)
    local isDisabled = item.VManipDisabled
    if action == "take" and not isDisabled then
        net.Start("PlayPickupAnimation")
        net.WriteString(item.uniqueID)
        net.Send(client)
    end
end

local networkStrings = {"PlayPickupAnimation"}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
