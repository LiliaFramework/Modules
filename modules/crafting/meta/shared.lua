local playerMeta = FindMetaTable("Player")
local entityMeta = FindMetaTable("Entity")
function playerMeta:CanCraft()
    return self:Alive() and self:getChar()
end

function entityMeta:IsTableLocked()
    if self:IsValid() and self.IsCraftingTable then return self:getNetVar("table_locked", false) end
    return true
end
