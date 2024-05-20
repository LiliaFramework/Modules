function MODULE:HasItem(inventory, itemType)
    for _, item in pairs(inventory:getItems()) do
        if item.uniqueID == itemType then return item end
    end
    return false
end
