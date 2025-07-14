local playerMeta = FindMetaTable("Player")
if SERVER then
    function playerMeta:ResetBAC()
        self:setNetVar("lia_alcoholism_bac", 0)
        hook.Run("BACChanged", self, 0)
        hook.Run("BACReset", self)
    end

    function playerMeta:AddBAC(amt)
        if not amt or not isnumber(amt) then return end
        local newBac = math.Clamp(self:getNetVar("lia_alcoholism_bac", 0) + amt, 0, 100)
        self:setNetVar("lia_alcoholism_bac", newBac)
        hook.Run("BACChanged", self, newBac)
        hook.Run("BACIncreased", self, amt, newBac)
    end
end

function playerMeta:IsDrunk()
    return self:GetBAC() > lia.config.get("DrunkNotifyThreshold", 50)
end

function playerMeta:GetBAC()
    return self:getNetVar("lia_alcoholism_bac", 0)
end
