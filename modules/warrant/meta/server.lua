local playerMeta = FindMetaTable("Player")
local MODULE = MODULE
function playerMeta:ToggleWanted(warranter)
    local warranted = not self:IsWanted()
    self:setNetVar("wanted", warranted)
    local warrantAction = warranted and "issued" or "removed"
    self:notify(string.format("You have been %s an active warrant.", warrantAction))
    if IsValid(warranter) then warranter:notify(string.format("You have %s an active warrant.", warrantAction)) end
    for _, ply in pairs(player.GetAll()) do
        if ply:CanSeeWarrantsIssued() then
            local expirationText = warranted and "was issued" or " has expired"
            local description = self:getChar() and self:getChar():getDesc() or "unknown description"
            ply:notify(string.format("A warrant has been %s for someone with %s%s.", warrantAction, description, expirationText))
        end
    end
end

function playerMeta:CanWarrantPlayers()
    return self:getNetVar("wanted", false) or self:HasPrivilege("Staff Permissions - Can Warrant People")
end

function playerMeta:CanSeeWarrantsIssued()
    return self:HasPrivilege("Staff Permissions - Can See Warrant Notifications") or table.HasValue(MODULE.CanSeeWarrantsNotifications, self:Team())
end