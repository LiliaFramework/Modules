local playerMeta = FindMetaTable("Player")
if SERVER then
    function playerMeta:ToggleWanted(warranter)
        local warranted = not self:IsWanted()
        self:setNetVar("wanted", warranted)
        local notificationMessage = warranted and L("WarrantIssued") or L("WarrantRemoved")
        self:notify(notificationMessage)
        if IsValid(warranter) then
            local warranterNotification = warranted and L("WarrantIssuedNotify") or L("WarrantRemovedNotify")
            warranter:notify(warranterNotification)
        end

        for _, ply in player.Iterator() do
            if ply:CanSeeWarrantsIssued() then
                local expirationText = warranted and L("WarrantExpirationIssued") or L("WarrantExpirationExpired")
                local description = self:getChar() and self:getChar():getDesc() or L("UnknownDescription")
                ply:notify(string.format(expirationText, description, warranted and L("issued") or L("expired")))
            end
        end
    end

    function playerMeta:CanWarrantPlayers()
        return self:getChar():hasFlags("P") or self:hasPrivilege("Staff Permissions - Can Warrant People")
    end

    function playerMeta:CanSeeWarrantsIssued()
        local faction = lia.faction.indices[self:Team()]
        return self:hasPrivilege("Staff Permissions - Can See Warrant Notifications") or faction.CanSeeWarrantsNotifications
    end
end

function playerMeta:IsWanted()
    return self:getNetVar("wanted", false)
end

function playerMeta:CanSeeWarrants()
    local faction = lia.faction.indices[self:Team()]
    return self:hasPrivilege("Staff Permissions - Can See Warrants") or faction.CanSeeWarrants
end
