local characterMeta = lia.meta.character
if SERVER then
    function characterMeta:ToggleWanted(warranter)
        local warranted = not self:IsWanted()
        self:setData("wanted", warranted)
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

        function characterMeta:CanWarrantPlayers()
            return self:hasFlags("P") or self:hasPrivilege("Staff Permissions - Can Warrant People")
        end

        function characterMeta:CanSeeWarrantsIssued()
            local faction = lia.faction.indices[self:Team()]
            return self:hasPrivilege("Staff Permissions - Can See Warrant Notifications") or faction.CanSeeWarrantsNotifications
        end
    end

    function characterMeta:IsWanted()
        return self:getData("wanted", false)
    end

    function characterMeta:CanSeeWarrants()
        local faction = lia.faction.indices[self:Team()]
        return self:hasPrivilege("Staff Permissions - Can See Warrants") or faction.CanSeeWarrants
    end
end