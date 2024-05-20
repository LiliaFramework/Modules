local MODULE = MODULE
if CLIENT then
    SWEP.PrintName = "StunGun"
    SWEP.Author = "STEAM_0:1:176123778"
    SWEP.Instructions = "STEAM_0:1:176123778"
    SWEP.Slot = 2
    SWEP.SlotPos = 1
end

SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "StunGun"
SWEP.ViewModel = "models/weapons/cg_ocrp2/v_taser.mdl"
SWEP.WorldModel = "models/weapons/cg_ocrp2/w_taser.mdl"
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
function SWEP:Initialize()
    if SERVER then self.LastFired = 0 end
end

function SWEP:PrimaryAttack()
    local client = self:GetOwner()
    local target = client:GetEyeTrace().Entity
    if client:IsNPC() then return end
    local curTime = CurTime()
    if curTime < self.LastFired + 5 then
        return
    end

    local maxDistance = 400
    local distance = client:GetPos():Distance(target:GetPos())
    if IsValid(target) and target:IsPlayer() and target:isStaffOnDuty() then
        target:notify("You were just attempted to be stunned by " .. client:Name() .. ".")
        client:notify("You can't tie a staff member!")
        return
    end

    if distance > maxDistance then
        self.LastFired = curTime
        client:ChatPrint("target is too far away!")
        return
    end

    if target:IsPlayer() and target:getChar() then
        self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
        self:EmitSound(self.Primary.Sound)
        self.LastFired = curTime
        self:ShootBullet(0, 1, self.Primary.Cone)
        if SERVER then MODULE:TasePlayer(ply, target) end
    else
        self.LastFired = curTime
        client:ChatPrint("Invalid Target/Miss Shot!")
    end
end

function SWEP:GetViewModelPosition(pos, ang)
    if not self.IronSightsPos then return pos, ang end
    pos = pos + ang:Forward() * -5
    local Offset = self.IronSightsPos
    if self.IronSightsAng then
        ang = ang * 1
        ang:RotateAroundAxis(ang:Right(), self.IronSightsAng.x)
        ang:RotateAroundAxis(ang:Up(), self.IronSightsAng.y)
        ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z)
    end

    local Right = ang:Right()
    local Up = ang:Up()
    local Forward = ang:Forward()
    pos = pos + Offset.x * Right
    pos = pos + Offset.y * Forward
    pos = pos + Offset.z * Up
    return pos, ang
end

if CLIENT then
    local LASER = Material('cable/redlaser')
    local function DrawLaser()
        for _, ply in pairs(player.GetAll()) do
            if not ply:Alive() or LocalPlayer() == ply or ply:GetActiveWeapon() == NULL or ply:GetActiveWeapon():GetClass() ~= 'weapon_stungun' then continue end
            render.SetMaterial(LASER)
            local bone = ply:LookupBone("ValveBiped.Bip01_R_Hand")
            if bone == nil then return end
            local m = ply:GetBoneMatrix(bone)
            if not IsValid(m) then return end
            local pos = m:GetTranslation() + ply:EyeAngles():Forward() * 8 + Vector(0, 0, 0.1) + ply:EyeAngles():Right() * -1
            local hitpos = ply:GetShootPos() + ply:EyeAngles():Forward() * SWEPConfig.MaxDist
            if ply:GetEyeTrace().HitPos:Length() <= SWEPConfig.MaxDist then hitpos = ply:GetEyeTrace().HitPos end
            render.DrawBeam(pos, hitpos, 2, 0, 12.5, Color(255, 0, 0, 255))
        end
    end

    hook.Add('PostDrawOpaqueRenderables', 'PlyMustSeeLaser', function() DrawLaser() end)
    function SWEP:ViewModelDrawn()
        local vm = self.Owner:GetViewModel()
        if not IsValid(vm) then return end
        local bones = vm:LookupBone("Trigger")
        local bone = vm:LookupBone("cartridge")
        if not bone then return end
        pos, ang = Vector(0, 0, 0), Angle(0, 0, 0)
        local m = vm:GetBoneMatrix(bone)
        local m2 = vm:GetBoneMatrix(bones)
        if m then
            pos, ang = m:GetTranslation(), m:GetAngles()
            pos2, ang2 = m2:GetTranslation(), m2:GetAngles()
        else
            return
        end

        render.SetMaterial(LASER)
        render.DrawBeam(pos, self.Owner:GetEyeTrace().HitPos, 2, 0, 12.5, Color(255, 0, 0, 255))
        ang2:RotateAroundAxis(ang2:Forward(), 90)
        ang2:RotateAroundAxis(ang2:Right(), 90)
        cam.Start3D2D(pos2 + ang2:Right() * -1 + ang2:Up() * 3.12 + ang2:Forward() * 0.12, ang2, 0.1)
        self:DrawScreen(0, 0, 65, 123)
        cam.End3D2D()
    end

    function SWEP:DrawScreen()
        local power = self:GetNWInt('power', 0)
        local i = power / 10
        draw.RoundedBox(0, 0, 0, 6, 10, Color(25, 25, 25, 255))
        draw.RoundedBox(0, 1, 0, 4, math.Clamp(i, 0, 10), Color(255 - power, 10 + power * 2, 25, 255))
    end
end
