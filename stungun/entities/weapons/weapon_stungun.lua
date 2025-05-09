local MODULE = MODULE
SWEP.PrintName = "StunGun"
SWEP.Author = "76561198312513285"
SWEP.Instructions = "76561198312513285"
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "StunGun"
SWEP.ViewModel = "models/weapons/custom/taser.mdl"
SWEP.WorldModel = "models/weapons/custom/w_taser.mdl"
SWEP.HoldType = "pistol"
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Primary.Sound = Sound("weapons/clipempty_rifle.wav")
SWEP.Primary.Recoil = 0.1
SWEP.Primary.Damage = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.5
SWEP.Primary.ClipSize = 1
SWEP.Primary.Delay = 0.06
SWEP.Primary.DefaultClip = 55
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"
SWEP.DrawCrosshair = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.IronSightsPos = Vector(-6, 2.2, -2)
SWEP.IronSightsAng = Vector(0.9, 0, 0)
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.LastFired = 0
SWEP.MaxDist = 400
function SWEP:Initialize()
    if SERVER then self.LastFired = 0 end
end

function SWEP:PrimaryAttack()
    local client = self:GetOwner()
    if client:IsNPC() then return end
    local curTime = CurTime()
    if curTime < self.LastFired + 5 then return end
    self.LastFired = curTime
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:EmitSound(self.Primary.Sound)
    local bullet = {}
    bullet.Num = 1
    bullet.Src = client:GetShootPos()
    local tr = client:GetEyeTrace()
    bullet.Dir = (tr.HitPos - bullet.Src):GetNormalized()
    bullet.Spread = Vector(0, 0, 0)
    bullet.Tracer = 1
    bullet.TracerName = "Tracer"
    bullet.Force = 5
    bullet.Damage = self.Primary.Damage
    bullet.Callback = function(_, tr, _)
        local target = tr.Entity
        if IsValid(target) and target:IsPlayer() and target:getChar() then
            local distance = client:GetPos():Distance(target:GetPos())
            if distance > self.MaxDist then
                client:notify(L("targetTooFar"))
                return
            end

            if target:isStaffOnDuty() then
                target:notify(L("stunAttempted", client:Name()))
                client:notify(L("cannotStunStaff"))
            else
                if SERVER then MODULE:TasePlayer(client, target) end
            end
        end
    end

    self:FireBullets(bullet)
end

function SWEP:GetViewModelPosition(pos, ang)
    if not self.IronSightsPos then return pos, ang end
    pos = pos + ang:Forward() * -5
    local Offset = self.IronSightsPos
    if self.IronSightsAng then
        ang:RotateAroundAxis(ang:Right(), self.IronSightsAng.x)
        ang:RotateAroundAxis(ang:Up(), self.IronSightsAng.y)
        ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z)
    end

    local Right = ang:Right()
    local Up = ang:Up()
    local Forward = ang:Forward()
    pos = pos + Offset.x * Right + Offset.y * Forward + Offset.z * Up
    return pos, ang
end

if CLIENT then
    local LASER = Material("cable/redlaser")
    local function DrawLaser()
        for _, client in player.Iterator() do
            if not client:Alive() or LocalPlayer() == client or not IsValid(client:GetActiveWeapon()) or client:GetActiveWeapon():GetClass() ~= "weapon_stungun" then continue end
            render.SetMaterial(LASER)
            local bone = client:LookupBone("ValveBiped.Bip01_R_Hand")
            if not bone then continue end
            local m = client:GetBoneMatrix(bone)
            if not m then continue end
            local pos = m:GetTranslation() + client:EyeAngles():Forward() * 8 + Vector(0, 0, 0.1) + client:EyeAngles():Right() * -1
            local trace = client:GetEyeTrace()
            local hitpos = client:GetShootPos() + client:EyeAngles():Forward() * self.MaxDist
            if client:GetShootPos():Distance(trace.HitPos) <= self.MaxDist then hitpos = trace.HitPos end
            render.DrawBeam(pos, hitpos, 2, 0, 12.5, Color(255, 0, 0, 255))
        end
    end

    hook.Add("PostDrawOpaqueRenderables", "PlyMustSeeLaser", DrawLaser)
    function SWEP:ViewModelDrawn()
        local vm = self.Owner:GetViewModel()
        if not IsValid(vm) then return end
        local triggerBone = vm:LookupBone("Trigger")
        local cartridgeBone = vm:LookupBone("cartridge")
        if not cartridgeBone then return end
        local m = vm:GetBoneMatrix(cartridgeBone)
        local m2 = vm:GetBoneMatrix(triggerBone)
        if m and m2 then
            local pos, _ = m:GetTranslation(), m:GetAngles()
            local pos2, ang2 = m2:GetTranslation(), m2:GetAngles()
            render.SetMaterial(LASER)
            render.DrawBeam(pos, self.Owner:GetEyeTrace().HitPos, 2, 0, 12.5, Color(255, 0, 0, 255))
            ang2:RotateAroundAxis(ang2:Forward(), 90)
            ang2:RotateAroundAxis(ang2:Right(), 90)
            cam.Start3D2D(pos2 + ang2:Right() * -1 + ang2:Up() * 3.12 + ang2:Forward() * 0.12, ang2, 0.1)
            self:DrawScreen(0, 0, 65, 123)
            cam.End3D2D()
        end
    end

    function SWEP:DrawScreen()
        local power = self:getNetVar("power", 0)
        local i = power / 10
        draw.RoundedBox(0, 0, 0, 6, 10, Color(25, 25, 25, 255))
        draw.RoundedBox(0, 1, 0, 4, math.Clamp(i, 0, 10), Color(255 - power, 10 + power * 2, 25, 255))
    end
end