--- A collection of utility functions for players.
-- @entitymeta Utilities
local playerMeta = FindMetaTable("Player")
--- Calculates the squared distance from the player to the specified entity.
-- @realm shared
-- @entity entity The entity to calculate the distance to.
-- @treturn Float The squared distance from the player to the entity.
-- @usage
-- local sqDist = player:squaredDistanceFromEnt(entity)
-- print("Squared Distance:", sqDist)
function playerMeta:squaredDistanceFromEnt(entity)
    return self:GetPos():DistToSqr(entity:GetPos())
end

--- Calculates the distance from the player to the specified entity.
-- @realm shared
-- @entity entity The entity to calculate the distance to.
-- @treturn Float The distance from the player to the entity.
-- @usage
-- local dist = player:distanceFromEnt(entity)
-- print("Distance:", dist)
function playerMeta:distanceFromEnt(entity)
    return self:GetPos():Distance(entity:GetPos())
end

--- Checks if the player is currently observing.
-- @realm shared
-- @treturn Boolean Whether the player is currently observing.
-- @usage
-- if player:isObserving() then
--     print("Player is observing.")
-- end
function playerMeta:isObserving()
    return self:GetMoveType() == MOVETYPE_NOCLIP and not self:hasValidVehicle()
end

--- Checks if the player is currently moving.
-- @realm shared
-- @treturn Boolean Whether the player is currently moving.
-- @usage
-- if player:isMoving() then
--     print("Player is moving.")
-- end
function playerMeta:isMoving()
    if not IsValid(self) or not self:Alive() then return false end
    local keydown = self:KeyDown(IN_FORWARD) or self:KeyDown(IN_BACK) or self:KeyDown(IN_MOVELEFT) or self:KeyDown(IN_MOVERIGHT)
    return keydown and self:OnGround()
end

--- Checks if the player is currently outside (in the sky).
-- @realm shared
-- @treturn Boolean Whether the player is currently outside (in the sky).
-- @usage
-- if player:isOutside() then
--     print("Player is outside.")
-- end
function playerMeta:isOutside()
    local trace = util.TraceLine({
        start = self:GetPos(),
        endpos = self:GetPos() + self:GetUp() * 9999999999,
        filter = self
    })
    return trace.HitSky
end