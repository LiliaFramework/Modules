local playerMeta = FindMetaTable("Player")
function playerMeta:IsWanted()
    return self:getNetVar("wanted", false)
end
