--- Meta Tables for Crafting.
-- @player Crafting
local playerMeta = FindMetaTable("Player")
--- Checks if the player can craft.
-- @treturn bool True if the player is alive and has a character, false otherwise.
-- @realm shared
function playerMeta:CanCraft()
    return self:Alive() and self:getChar()
end