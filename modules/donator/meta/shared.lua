--- Meta Tables for Donator.
-- @modmeta Donator

local playerMeta = FindMetaTable("Player")

--- Retrieves the number of additional character slots the player has.
-- @treturn int The number of additional character slots.
-- @realm shared
function playerMeta:GetAdditionalCharSlots()
    return self:getLiliaData("AdditionalCharSlots", 0)
end

if SERVER then
    --- Sets the number of additional character slots for the player.
    -- @int val The number of additional character slots to set.
    -- @realm server
    function playerMeta:SetAdditionalCharSlots(val)
        self:setLiliaData("AdditionalCharSlots", val)
        self:saveLiliaData()
    end

    --- Adds a specified number of additional character slots to the player.
    -- @int AddValue The number of additional character slots to add. Defaults to 1 if not specified.
    -- @realm server
    function playerMeta:GiveAdditionalCharSlots(AddValue)
        AddValue = math.max(0, AddValue or 1)
        self:SetAdditionalCharSlots(self:GetAdditionalCharSlots() + AddValue)
    end
end
