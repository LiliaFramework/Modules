--- Meta Tables for Alcoholism.
-- @playermeta Alcoholism
local MODULE = MODULE
local playerMeta = FindMetaTable("Player")
local DrunkNotifyThreshold = MODULE.DrunkNotifyThreshold

if SERVER then
    --- Resets the player's blood alcohol content (BAC) to 0.
    -- @realm server
    function playerMeta:ResetBAC()
        self:SetNW2Int("lia_alcoholism_bac", 0)
    end

    --- Adds a specified amount to the player's BAC, clamping the value between 0 and 100.
    -- @int amt The amount to add to the BAC.
    -- @realm server
    function playerMeta:AddBAC(amt)
        if not amt or not isnumber(amt) then return end
        self:SetNW2Int("lia_alcoholism_bac", math.Clamp(self:GetNW2Int("lia_alcoholism_bac", 0) + amt, 0, 100))
    end
end

--- Checks if the player's BAC is above the drunk notification threshold.
-- @treturn bool True if the player's BAC is above the drunk notification threshold, false otherwise.
-- @realm shared
function playerMeta:IsDrunk()
    return self:GetBAC() > DrunkNotifyThreshold
end

--- Retrieves the player's current BAC.
-- @treturn integer The current BAC of the player.
-- @realm shared
function playerMeta:GetBAC()
    return self:GetNW2Int("lia_alcoholism_bac", 0)
end
