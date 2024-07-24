--- Meta Tables for Warrant.
-- @player Warrant
local MODULE = MODULE
local playerMeta = FindMetaTable("Player")
local CanSeeWarrants = MODULE.CanSeeWarrants
local CanSeeWarrantsNotifications = MODULE.CanSeeWarrantsNotifications

if SERVER then
    --- Toggles the wanted status of the player.
    -- @param warranter The player who issued or removed the warrant.
    -- @realm server
    function playerMeta:ToggleWanted(warranter)
        local warranted = not self:IsWanted()
        self:setNetVar("wanted", warranted)
        local warrantAction = warranted and "issued" or "removed"
        self:notify(string.format("You have been %s an active warrant.", warrantAction))

        if IsValid(warranter) then
            warranter:notify(string.format("You have %s an active warrant.", warrantAction))
        end

        for _, ply in pairs(player.GetAll()) do
            if ply:CanSeeWarrantsIssued() then
                local expirationText = warranted and "was issued" or "has expired"
                local description = self:getChar() and self:getChar():getDesc() or "unknown description"
                ply:notify(string.format("A warrant has been %s for someone with %s %s.", warrantAction, description, expirationText))
            end
        end
    end

    --- Checks if the player can warrant other players.
    -- @treturn bool True if the player can warrant others, false otherwise.
    -- @realm server
    function playerMeta:CanWarrantPlayers()
        return self:getNetVar("wanted", false) or self:HasPrivilege("Staff Permissions - Can Warrant People")
    end

    --- Checks if the player can see issued warrants.
    -- @treturn bool True if the player can see issued warrants, false otherwise.
    -- @realm server
    function playerMeta:CanSeeWarrantsIssued()
        return self:HasPrivilege("Staff Permissions - Can See Warrant Notifications") or table.HasValue(CanSeeWarrantsNotifications, self:Team())
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
    return self:HasPrivilege("Staff Permissions - Can See Warrants") or table.HasValue(CanSeeWarrants, self:Team())
end
