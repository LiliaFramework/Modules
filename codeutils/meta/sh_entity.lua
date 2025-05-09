local entityMeta = FindMetaTable("Entity")
function entityMeta:getViewAngle(pos)
    local diff = pos - self:EyePos()
    diff:Normalize()
    return math.abs(math.deg(math.acos(self:EyeAngles():Forward():Dot(diff))))
end

function entityMeta:inFov(entity, fov)
    return self:getViewAngle(entity:EyePos()) < (fov or 88)
end

function entityMeta:isInRoom(target)
    local tracedata = {}
    tracedata.start = self:GetPos()
    tracedata.endpos = target:GetPos()
    local trace = util.TraceLine(tracedata)
    return not trace.HitWorld
end

function entityMeta:isScreenVisible(entity, maxDist, fov)
    return self:EyePos():DistToSqr(entity:EyePos()) < (maxDist or 512 * 512) and self:IsLineOfSightClear(entity:EyePos()) and self:inFov(entity, fov)
end

function entityMeta:canSeeEntity(entity, fov)
    if not (IsValid(self) and IsValid(entity)) then return false end
    if not (self:IsPlayer() or self:IsNPC()) then return false end
    if not self:IsLineOfSightClear(entity) then return false end
    return self:inFov(entity, fov)
end