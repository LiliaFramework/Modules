local MODULE = MODULE
function MODULE:OnNPCKilled(ent)
    if not ent:IsNPC() then return end
    hook.Run("NPCDropCheck", ent)
    local weights = self.DropTable[ent:GetClass()]
    if not weights then
        hook.Run("NPCDropNoTable", ent)
        return
    end

    local totalWeight = 0
    for _, w in pairs(weights) do
        if isnumber(w) and w > 0 then totalWeight = totalWeight + w end
    end

    if totalWeight <= 0 then
        hook.Run("NPCDropNoItems", ent)
        return
    end

    local choice = math.random(totalWeight)
    hook.Run("NPCDropRoll", ent, choice, totalWeight)
    for itemName, weight in pairs(weights) do
        if choice <= weight then
            lia.item.spawn(itemName, ent:GetPos() + Vector(0, 0, 16), nil, ent:GetAngles())
            hook.Run("NPCDroppedItem", ent, itemName)
            return
        end

        choice = choice - weight
    end

    hook.Run("NPCDropFailed", ent)
end