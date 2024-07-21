--- Meta Tables for Crafting.
-- @modmeta Crafting

local playerMeta = FindMetaTable("Player")
local entityMeta = FindMetaTable("Entity")

if SERVER then
    --- Locks or unlocks a crafting table.
    -- @bool locked Whether the table should be locked or unlocked.
    -- @treturn bool True if the operation was successful, false otherwise.
    -- @realm server
    function entityMeta:LockTable(locked)
        assert(isbool(locked), "Expected bool, got " .. type(locked))
        if self:IsValid() and self.IsCraftingTable then
            self:setNetVar("table_locked", locked)
            return true
        end
        return false
    end
end

--- Checks if the player can craft.
-- @treturn bool True if the player is alive and has a character, false otherwise.
-- @realm shared
function playerMeta:CanCraft()
    return self:Alive() and self:getChar()
end

--- Checks if a crafting table is locked.
-- @treturn bool True if the table is locked, false otherwise.
-- @realm shared
function entityMeta:IsTableLocked()
    if self:IsValid() and self.IsCraftingTable then
        return self:getNetVar("table_locked", false)
    end
    return true
end
