local MODULE = MODULE
local playerMeta = FindMetaTable("Player")

function playerMeta:IsWanted()
    return self:getNetVar("wanted", false)
end

function playerMeta:CanSeeWarrants()
    return self:HasPrivilege("Staff Permissions - Can See Warrants") or table.HasValue(MODULE.CanSeeWarrants, self:Team())
end