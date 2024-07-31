local FreeLookEnabled = CreateClientConVar("freelook_enabled", 0, true)
local freelooking, LookX, LookY, InitialAng, CoolAng, ZeroAngle = false, 0, 0, Angle(), Angle(), Angle()

function MODULE:Isinsights(ply)
    local weapon = ply:GetActiveWeapon()
    return self.FreelookBlockADS and (ply:KeyDown(IN_ATTACK2) or (weapon.GetInSights and weapon:GetInSights()) or (weapon.ArcCW and weapon:GetState() == ArcCW.STATE_SIGHTS) or (weapon.GetIronSights and weapon:GetIronSights()))
end

function MODULE:Holdingbind(ply)
    if not input.LookupBinding("freelook") then
        return ply:KeyDown(IN_WALK)
    else
        return freelooking
    end
end

function MODULE:CalcView(ply, origin, angles, fov)
    if not ply:getChar() or not FreeLookEnabled then return end
    local smoothness = math.Clamp(self.FreelookSmooth, 0.1, 2)
    CoolAng = LerpAngle(0.15 * smoothness, CoolAng, Angle(LookY, -LookX, 0))
    if not self:Holdingbind(ply) and CoolAng.p < 0.05 and CoolAng.p > -0.05 or self:Isinsights(ply) and CoolAng.p < 0.05 and CoolAng.p > -0.05 or not system.HasFocus() or ply:ShouldDrawLocalPlayer() then
        InitialAng = angles + CoolAng
        LookX, LookY = 0, 0
        CoolAng = ZeroAngle
        return
    end

    angles.p = angles.p + CoolAng.p
    angles.y = angles.y + CoolAng.y
end

function MODULE:CalcViewModelView(wep, vm, oPos, oAng, pos, ang)
    local lp = LocalPlayer()
    if not lp:getChar() or not FreeLookEnabled then return end
    local MWBased = wep.m_AimModeDeltaVelocity and -1.5 or 1
    ang.p = ang.p + CoolAng.p / 2.5 * MWBased
    ang.y = ang.y + CoolAng.y / 2.5 * MWBased
end

function MODULE:InputMouseApply(cmd, x, y, ang)
    local lp = LocalPlayer()
    if not lp:getChar() or not FreeLookEnabled then return end
    if not self:Holdingbind(lp) or self:Isinsights(lp) or lp:ShouldDrawLocalPlayer() then
        LookX, LookY = 0, 0
        return
    end

    InitialAng.z = 0
    cmd:SetViewAngles(InitialAng)
    LookX = math.Clamp(LookX + x * 0.02, -self.FreelookLimH, self.FreelookLimH)
    LookY = math.Clamp(LookY + y * 0.02, -self.FreelookLimV, self.FreelookLimV)
    return true
end

function MODULE:StartCommand(ply, cmd)
    if not ply:IsPlayer() or not ply:Alive() then return end
    if not ply:getChar() then return end
    if not self.FreelookBlockFire then return end
    if not self:Holdingbind(ply) or self:Isinsights(ply) or ply:ShouldDrawLocalPlayer() then return end
    cmd:RemoveKey(IN_ATTACK)
end

function MODULE:SetupQuickMenu(menu)
    menu:addCheck("Free look Enabled", function(_, state)
        if state then
            RunConsoleCommand("freelook_enabled", "1")
        else
            RunConsoleCommand("freelook_enabled", "0")
        end
    end, FreeLookEnabled:GetBool())
end

concommand.Add("+freelook", function(ply, cmd, args) freelooking = true end)
concommand.Add("-freelook", function(ply, cmd, args) freelooking = false end)