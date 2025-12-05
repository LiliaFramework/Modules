local MODULE = MODULE
function MODULE:OnNPCKilled(ent)
    if not ent:IsNPC() then return end
    local weights = self.DropTable[ent:GetClass()]
    if not weights then return end
    local totalWeight = 0
    for _, w in pairs(weights) do
        if isnumber(w) and w > 0 then totalWeight = totalWeight + w end
    end

    if totalWeight <= 0 then return end
    local choice = math.random(totalWeight)
    for itemName, weight in pairs(weights) do
        if choice <= weight then
            lia.item.spawn(itemName, ent:GetPos() + Vector(0, 0, 16), nil, ent:GetAngles())
            return
        end

        choice = choice - weight
    end
end
