function MODULE:isSuitableForTrunk(entity)
    return IsValid(entity) and entity:IsVehicle()
end

function MODULE:InitializeStorage(entity)
    if self.Vehicles[entity] then return end
    local key = entity:IsVehicle() and "vehicle" or entity:GetModel():lower()
    local def = self.StorageDefinitions[key]
    if not def then return end
    self.Vehicles[entity] = true
    if SERVER then
        entity.receivers = {}
        lia.inventory.instance(def.invType, {
            maxWeight = def.weight
        }):next(function(inv)
            inv.isStorage = true
            entity:setNetVar("inv", inv:getID())
            hook.Run("StorageInventorySet", self, inv, entity:IsVehicle())
        end)
    end
end