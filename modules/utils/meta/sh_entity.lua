--- A collection of utility functions for entities.
-- @entitymeta Utilities
local entityMeta = FindMetaTable("Entity")
--- Gets the view angle between the entity and a specified position.
-- @realm shared
-- @vector pos The position to calculate the view angle towards.
-- @treturn float The view angle in degrees.
-- @usage
-- local angle = entity:getViewAngle(targetPos)
-- print("View angle:", angle)
function entityMeta:getViewAngle(pos)
    local diff = pos - self:EyePos()
    diff:Normalize()
    return math.abs(math.deg(math.acos(self:EyeAngles():Forward():Dot(diff))))
end

--- Checks if the entity is within the field of view of another entity.
-- @realm shared
-- @entity entity to check the field of view against.
-- @float fov The field of view angle in degrees.
-- @treturn Boolean True if the entity is within the field of view, false otherwise.
-- @usage
-- if entity:inFov(playerEntity, 90) then
--     print("Entity is within the player's field of view.")
-- end
function entityMeta:inFov(entity, fov)
    return self:getViewAngle(entity:EyePos()) < (fov or 88)
end

--- Checks if the entity is inside a room (i.e., not blocked by world geometry) with another target entity.
-- @realm shared
-- @entity target The target entity to check for room visibility.
-- @treturn Boolean True if the entity is in the same room as the target entity, false otherwise.
-- @usage
-- if entity:isInRoom(targetEntity) then
--     print("Entities are in the same room.")
-- else
--     print("Entities are not in the same room.")
-- end
function entityMeta:isInRoom(target)
    local tracedata = {}
    tracedata.start = self:GetPos()
    tracedata.endpos = target:GetPos()
    local trace = util.TraceLine(tracedata)
    return not trace.HitWorld
end

--- Checks if the entity has a clear line of sight to another entity and is within a specified distance and field of view angle.
-- @realm shared
-- @entity entity The entity to check visibility against.
-- @float maxDist The maximum distance squared within which the entity can see the other entity.
-- @float fov The field of view angle in degrees.
-- @treturn Boolean True if the entity has a clear line of sight to the other entity within the specified distance and field of view angle, false otherwise.
-- @usage
-- if entity:isScreenVisible(targetEntity, 300000, 90) then
--     print("Entity is visible on the screen.")
-- end
function entityMeta:isScreenVisible(entity, maxDist, fov)
    return self:EyePos():DistToSqr(entity:EyePos()) < (maxDist or 512 * 512) and self:IsLineOfSightClear(entity:EyePos()) and self:inFov(entity, fov)
end

--- Checks if the entity can see another entity.
-- Combines validity, line of sight, and field of view checks.
-- @realm shared
-- @entity entity The entity to check visibility against.
-- @float fov Optional field of view angle in degrees.
-- @treturn Boolean True if the entity can see the target entity, false otherwise.
-- @usage
-- if entity:canSeeEntity(targetEntity) then
--     print("Entity can see the target entity.")
-- else
--     print("Entity cannot see the target entity.")
-- end
function entityMeta:canSeeEntity(entity, fov)
    if not (IsValid(self) and IsValid(entity)) then return false end
    if not (self:IsPlayer() or self:IsNPC()) then return false end
    if not self:IsLineOfSightClear(entity) then return false end
    return self:inFov(entity, fov)
end