--- Meta Tables for Warrant.
-- @playermeta Warrant
local MODULE = MODULE
local playerMeta = FindMetaTable("Player")

if SERVER then
    --- Toggles the wanted status of the player.
    -- @client warranter The player who issued or removed the warrant.
    -- @realm server
    function playerMeta:ToggleWanted(warranter)
        local warranted = not self:IsWanted()
        self:setNetVar("wanted", warranted)
        local notificationMessage = warranted and L("WarrantIssued") or L("WarrantRemoved")
        self:notify(notificationMessage)
        if IsValid(warranter) then
            local warranterNotification = warranted and L("WarrantIssuedNotify") or L("WarrantRemovedNotify")
            warranter:notify(warranterNotification)
        end

        for _, ply in pairs(player.GetAll()) do
            if ply:CanSeeWarrantsIssued() then
                local expirationText = warranted and L("WarrantExpirationIssued") or L("WarrantExpirationExpired")
                local description = self:getChar() and self:getChar():getDesc() or L("UnknownDescription")
                ply:notify(string.format(expirationText, description, warranted and L("issued") or L("expired")))
            end
        end
    end
    --- Checks if the player can warrant other players.
    -- @treturn bool True if the player can warrant others, false otherwise.
    -- @realm server
    function playerMeta:CanWarrantPlayers()
        return self:getChar():hasFlags("P") or self:HasPrivilege("Staff Permissions - Can Warrant People")
    end

    --- Checks if the player can see issued warrants.
    -- @treturn bool True if the player can see issued warrants, false otherwise.
    -- @realm server
    function playerMeta:CanSeeWarrantsIssued()
        return self:HasPrivilege("Staff Permissions - Can See Warrant Notifications") or table.HasValue(MODULE.CanSeeWarrantsNotifications, self:Team())
    end
end

--- Checks if the player is wanted.
-- @treturn bool True if the player is wanted, false otherwise.
-- @realm shared
function playerMeta:IsWanted()
    return self:getNetVar("wanted", false)
end

--- Checks if the player can see warrants.
-- @treturn bool True if the player can see warrants, false otherwise.
-- @realm shared
function playerMeta:CanSeeWarrants()
    return self:HasPrivilege("Staff Permissions - Can See Warrants") or table.HasValue(MODULE.CanSeeWarrants, self:Team())
end
