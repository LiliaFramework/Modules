local MODULE = MODULE
MODULE.currAng = MODULE.currAng or angle_zero
MODULE.currPos = MODULE.currPos or vector_origin
MODULE.targetAng = MODULE.targetAng or angle_zero
MODULE.targetPos = MODULE.targetPos or vector_origin
MODULE.resultAng = MODULE.resultAng or angle_zero
local entMeta = FindMetaTable("Entity")
local vecMeta = FindMetaTable("Vector")
local velo = entMeta.GetVelocity
local twoD = vecMeta.Length2D
local math_Clamp = math.Clamp
function MODULE:CalcView(pl, pos, ang, fov)
    if not IsValid(LocalPlayer()) or IsValid(lia.gui.char) then return end
    if not LocalPlayer():getChar() then return end
    if lia.gui.character and IsValid(lia.gui.character) then return end
    if pl:canOverrideView() or pl:GetViewEntity() ~= pl then return end
    if not lia.option.get("FirstPersonEffects", true) then return end
    local realTime = RealTime()
    local frameTime = FrameTime()
    local vel = math.floor(twoD(velo(pl)))
    if pl:OnGround() then
        local walkSpeed = lia.config.get("WalkSpeed")
        if vel > walkSpeed + 40 and not pl.isBreathing then
            local runSpeed = lia.config.get("RunSpeed")
            local perc = math_Clamp(vel / runSpeed * 100, 0.5, 5)
            self.targetAng = Angle(math.abs(math.cos(realTime * runSpeed / 33) * 0.4 * perc), math.sin(realTime * runSpeed / 29) * 0.5 * perc, 0)
            self.targetPos = Vector(0, 0, math.sin(realTime * runSpeed / 30) * 0.4 * perc)
        else
            local perc = math_Clamp((vel / walkSpeed * 100) / 60, 0, 10)
            self.targetAng = Angle(math.cos(realTime * walkSpeed / 8) * 0.2 * perc, 0, 0)
            self.targetPos = Vector(0, 0, math.sin(realTime * walkSpeed / 8) * 0.5 * perc)
        end
    else
        if pl:WaterLevel() >= 2 then
            self.targetAng = angle_zero
            self.targetPos = vector_origin
        else
            vel = math.abs(pl:GetVelocity().z)
            local af = 0
            local perc = math_Clamp(vel / 200, 0.1, 8)
            if perc > 1 then af = perc end
            self.targetAng = Angle(math.cos(realTime * 15) * 2 * perc + math.Rand(-af * 2, af * 2), math.sin(realTime * 15) * 2 * perc + math.Rand(-af * 2, af * 2), math.Rand(-af * 5, af * 5))
            self.targetPos = Vector(math.cos(realTime * 15) * 0.5 * perc, math.sin(realTime * 15) * 0.5 * perc, 0)
        end
    end

    self.resultAng = LerpAngle(math_Clamp(math_Clamp(frameTime, 1 / 120, 1) * 10, 0, 5), self.resultAng, ang)
    self.currAng = LerpAngle(frameTime * 10, self.currAng, self.targetAng)
    self.currPos = LerpVector(frameTime * 10, self.currPos, self.targetPos)
    return {
        origin = pos + self.currPos,
        angles = self.resultAng + self.currAng,
        fov = fov
    }
end
