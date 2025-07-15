local entityMeta = FindMetaTable("Entity")
--[[
entityMeta:getViewAngle(pos)

Description:
    Calculates the angle difference between the entity's view and a position.

Parameters:
    pos (Vector) — World position to test.

Returns:
    number — Absolute angle difference in degrees.

Realm:
    Shared

Example Usage:
    local angDiff = ent:getViewAngle(Vector(0,0,0))
]]
function entityMeta:getViewAngle(pos)
    local diff = pos - self:EyePos()
    diff:Normalize()
    return math.abs(math.deg(math.acos(self:EyeAngles():Forward():Dot(diff))))
end

--[[
entityMeta:inFov(entity, fov)

Description:
    Determines whether another entity is within this entity's field of view.

Parameters:
    entity (Entity) — Target to check.
    fov    (number) — Field of view in degrees (default 88).

Returns:
    boolean — True if the target is within the FOV.

Realm:
    Shared

Example Usage:
    if ent:inFov(target, 60) then ... end
]]
function entityMeta:inFov(entity, fov)
    return self:getViewAngle(entity:EyePos()) < (fov or 88)
end

--[[
entityMeta:isInRoom(target)

Description:
    Checks if there is a direct line between this entity and the target.

Parameters:
    target (Entity) — Target entity.

Returns:
    boolean — True if no world geometry blocks the trace.

Realm:
    Shared

Example Usage:
    if ent:isInRoom(other) then ... end
]]
function entityMeta:isInRoom(target)
    local tracedata = {}
    tracedata.start = self:GetPos()
    tracedata.endpos = target:GetPos()
    local trace = util.TraceLine(tracedata)
    return not trace.HitWorld
end

--[[
entityMeta:isScreenVisible(entity, maxDist, fov)

Description:
    Checks if an entity is visible on screen within distance and FOV limits.

Parameters:
    entity  (Entity) — Target entity.
    maxDist (number) — Maximum squared distance (default 512^2).
    fov     (number) — Field of view in degrees.

Returns:
    boolean — True if visible.

Realm:
    Shared

Example Usage:
    if ent:isScreenVisible(target, 1024^2, 70) then ... end
]]
function entityMeta:isScreenVisible(entity, maxDist, fov)
    return self:EyePos():DistToSqr(entity:EyePos()) < (maxDist or 512 * 512) and self:IsLineOfSightClear(entity:EyePos()) and self:inFov(entity, fov)
end

--[[
entityMeta:canSeeEntity(entity, fov)

Description:
    Determines if this entity can see another using line-of-sight and FOV.

Parameters:
    entity (Entity) — Target entity.
    fov    (number) — Field of view in degrees.

Returns:
    boolean — True if the target is visible.

Realm:
    Shared

Example Usage:
    if ent:canSeeEntity(target) then ... end
]]
function entityMeta:canSeeEntity(entity, fov)
    if not (IsValid(self) and IsValid(entity)) then return false end
    if not (self:IsPlayer() or self:IsNPC()) then return false end
    if not self:IsLineOfSightClear(entity) then return false end
    return self:inFov(entity, fov)
end
