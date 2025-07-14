function MODULE:OnPlayerInteractItem(client, action, item)
    local isDisabled = item.VManipDisabled
    if action == "take" and not isDisabled then
        hook.Run("PreVManipPickup", client, item)
        net.Start("PlayPickupAnimation")
        net.WriteString(item.uniqueID)
        net.Send(client)
        hook.Run("VManipPickup", client, item)
    end
end

local networkStrings = {"PlayPickupAnimation"}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
