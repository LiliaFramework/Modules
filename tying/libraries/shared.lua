local playerMeta = FindMetaTable("Player")

function playerMeta:IsHandcuffed()
    return self:getNetVar("restricted", false)
end