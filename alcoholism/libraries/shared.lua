function MODULE:InitializedModules()
    for id, d in pairs(self.AlcoholItems) do
        local ITEM = lia.item.register(id, "base_alcohol", nil, nil, true)
        ITEM.uniqueID = id
        ITEM.name = d.name
        ITEM.model = d.model or ""
        ITEM.category = d.category or "Alcohol"
        ITEM.price = d.price or 0
        ITEM.weight = d.weight or 0
        ITEM.height = d.height or 1
        ITEM.width = d.width or 1
        ITEM.abv = d.abv or 0
    end
end
