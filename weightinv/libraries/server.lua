function MODULE:PlayerLoadedChar(client, character)
    local inv = character:getInv()
    if inv then
        local baseMax = lia.config.get("invMaxWeight")
        local curMax = tonumber(inv:getData("maxWeight", baseMax))
        if curMax ~= baseMax then return curMax end
        local defaultMax = hook.Run("GetDefaultInventoryMaxWeight", client) or baseMax
        if curMax ~= defaultMax then
            inv:setData("maxWeight", defaultMax)
            inv:sync(client)
        end
    end
end