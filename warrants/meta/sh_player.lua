local characterMeta = lia.meta.character
if SERVER then
    function characterMeta:ToggleWanted(warranter)
        local warranted = not self:IsWanted()
        hook.Run("PreWarrantToggle", self, warranter, warranted)
        self:setWanted(warranted)
        hook.Run("WarrantStatusChanged", self, warranter, warranted)
        local notificationMessage = warranted and L("WarrantIssued") or L("WarrantRemoved")
        self:notify(notificationMessage)
        if IsValid(warranter) then
            local warranterNotification = warranted and L("WarrantIssuedNotify") or L("WarrantRemovedNotify")
            warranter:notify(warranterNotification)
            lia.log.add(warranter, warranted and "warrantIssue" or "warrantRemove", self:getPlayer() or self)
        end

        for _, ply in player.Iterator() do
            if ply:CanSeeWarrantsIssued() then
                local expirationText = warranted and L("WarrantExpirationIssued", self:getDesc()) or L("WarrantExpirationExpired", self:getDesc())
                local description = self and self:getDesc() or L("UnknownDescription")
                ply:notify(string.format(expirationText, description, warranted and L("issued") or L("expired")))
            end
        end

        hook.Run("PostWarrantToggle", self, warranter, warranted)
    end

    function characterMeta:CanWarrantPlayers()
        return self:hasFlags("P") or self:hasPrivilege("canWarrantPeople")
    end

    function characterMeta:CanSeeWarrantsIssued()
        local faction = lia.faction.indices[self:Team()]
        return self:hasPrivilege("canSeeWarrantNotifications") or faction.CanSeeWarrantsNotifications
    end

    function characterMeta:IsWanted()
        return self:getWanted()
    end

    function characterMeta:CanSeeWarrants()
        local faction = lia.faction.indices[self:Team()]
        return self:hasPrivilege("canSeeWarrants") or faction.CanSeeWarrants
    end
end