local entityMeta = FindMetaTable("Entity")
function entityMeta:LockTable(locked)
    assert(isbool(locked), "Expected bool, got", type(locked))
    if self:IsValid() and self.IsCraftingTable then
        self:setNetVar("table_locked", locked)
        return true
    end
    return false
end
