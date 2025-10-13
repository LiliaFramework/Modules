local playerMeta = FindMetaTable("Player")
function playerMeta:isHandcuffed()
    return self:getNetVar("restricted", false)
end
