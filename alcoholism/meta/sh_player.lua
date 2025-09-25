local playerMeta = FindMetaTable("Player")
if SERVER then
    function playerMeta:ResetBAC()
        hook.Run("PreBACReset", self)
        self:setNetVar("lia_alcoholism_bac", 0)
        hook.Run("BACChanged", self, 0)
        hook.Run("BACReset", self)
        hook.Run("PostBACReset", self)
        lia.log.add(self, "bacReset")
    end

    function playerMeta:AddBAC(amt)
        if not amt or not isnumber(amt) then return end
        hook.Run("PreBACIncrease", self, amt)
        local oldBac = self:getNetVar("lia_alcoholism_bac", 0)
        local newBac = math.Clamp(oldBac + amt, 0, 100)
        self:setNetVar("lia_alcoholism_bac", newBac)
        hook.Run("BACChanged", self, newBac)
        lia.log.add(self, "bacIncrease", amt, newBac)
        hook.Run("BACIncreased", self, amt, newBac)
        local threshold = lia.config.get("DrunkNotifyThreshold", 50)
        if oldBac < threshold and newBac >= threshold then hook.Run("BACThresholdReached", self, newBac) end
    end
end

function playerMeta:IsDrunk()
    return self:GetBAC() > lia.config.get("DrunkNotifyThreshold", 50)
end

function playerMeta:GetBAC()
    return self:getNetVar("lia_alcoholism_bac", 0)
end
