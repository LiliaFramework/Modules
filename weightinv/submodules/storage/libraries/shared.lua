function MODULE:isSuitableForTrunk(entity)
    return IsValid(entity) and entity:IsVehicle()
end

function MODULE:InitializeStorage(entity)
    if not IsValid(entity) or self.Vehicles[entity] then return end
    local model = entity:GetModel()
    if not model then return end
    local key = entity:IsVehicle() and "vehicle" or model:lower()
    local def = self.StorageDefinitions[key]
    if not def then return end
    self.Vehicles[entity] = true
    if SERVER then
        entity.receivers = {}
        local params = def.invData or {}
        if def.weight then params.maxWeight = def.weight end
        lia.inventory.instance(def.invType, params):next(function(inv)
            inv.isStorage = true
            entity:setNetVar("inv", inv:getID())
            hook.Run("StorageInventorySet", self, inv, entity:IsVehicle())
        end)
    end
end
