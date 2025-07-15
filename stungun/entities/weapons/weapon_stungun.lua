SWEP.PrintName = "StunGun"
SWEP.Author = "Samael"
SWEP.Purpose = "A StunGun"
SWEP.Instructions = "Samael"
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "Lilia"
SWEP.ViewModel = "models/weapons/Custom/taser.mdl"
SWEP.WorldModel = "models/weapons/Custom/w_taser.mdl"
SWEP.HoldType = "pistol"
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Primary = {
    Sound = Sound("weapons/clipempty_rifle.wav"),
    Recoil = 0.1,
    Damage = 0,
    NumShots = 1,
    Cone = 0.05,
    ClipSize = 1,
    Delay = 0.06,
    DefaultClip = 55,
    Automatic = true,
    Ammo = "pistol"
}

SWEP.Secondary = {
    ClipSize = -1,
    DefaultClip = -1,
    Automatic = false,
    Ammo = "none"
}

SWEP.DrawCrosshair = false
SWEP.IronSightsPos = Vector(-6, 2.2, -2)
SWEP.IronSightsAng = Vector(0.9, 0, 0)
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
function SWEP:Initialize()
    if SERVER then
        self.Laser = false
        self.LastUpdated = CurTime()
    end
end

function SWEP:MinutkaBreda(ply, ent)
    local maxDist = lia.config.get("MaxDist")
    ent:SetPoint(ply:GetShootPos() + ply:GetForward() * maxDist / 2)
end

function SWEP:CreateFakeRope()
    if IsValid(self.ent2) then self.ent2:Remove() end
    self.ent2 = ents.Create("aprop")
    self.ent2:Spawn()
    self.ent2:SetColor(Color(0, 0, 0, 0))
    self.ent2:SetMoveType(MOVETYPE_NONE)
    local hand = self:GetOwner():LookupBone("ValveBiped.Bip01_r_hand") or 0
    local pos, ang = self:GetOwner():GetBonePosition(hand)
    self.ent2:SetPos(pos + ang:Forward() * 20)
    local dist = lia.config.get("MaxDist")
    constraint.Rope(self.ent, self.ent2, 0, 0, Vector(0.1, 0.1, 0), Vector(), dist, 80, 0, 1, "cable/blue_elec", false)
    constraint.Rope(self.ent, self.ent2, 0, 0, Vector(-0.1, -0.1, 0), Vector(), dist, 80, 0, 1, "cable/redlaser", false)
    self.Target = self.ent2
    self.dist = dist
    self:MinutkaBreda(self:GetOwner(), self.ent2)
end

function SWEP:CreateMarionete(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if IsValid(ply.HelpEnt) then ply.HelpEnt:Remove() end
    ply.HelpEnt = ents.Create("prop_physics")
    ply.HelpEnt:SetModel("models/hunter/plates/plate.mdl")
    ply.HelpEnt:PhysicsInit(SOLID_VPHYSICS)
    ply.HelpEnt:Spawn()
    ply.HelpEnt:DrawShadow(false)
    ply.HelpEnt:SetMoveType(MOVETYPE_VPHYSICS)
    ply.HelpEnt:Activate()
    ply.HelpEnt:GetPhysicsObject():SetMass(5500)
    ply.HelpEnt:SetAngles(Angle())
    ply.HelpEnt:SetPos(ply:GetPos())
    ply.HelpEnt:SetModelScale(0.2, 0)
    ply.HelpEnt:SetSolid(SOLID_NONE)
    ply.HelpEnt:SetParent(ply)
    ply.HelpEnt:Fire("SetParentAttachmentMaintainOffset", "chest", 0.01)
    return ply.HelpEnt
end

function SWEP:CreateHelpingProp()
    if IsValid(self.ent) then self.ent:Remove() end
    self.ent = ents.Create("aprop")
    self.ent:Spawn()
    local hand = self:GetOwner():LookupBone("ValveBiped.Bip01_r_hand") or 0
    local pos, ang = self:GetOwner():GetBonePosition(hand)
    self.ent:SetAngles(ang)
    self.ent:SetPos(pos + self.ent:GetForward() * 3 + self.ent:GetUp() * -3 + self.ent:GetRight() * 1.2)
    self.ent:SetParentAE(self:GetOwner())
    self.OverPower = false
    self.Taser = nil
    self.Target = nil
end

local function GetSound(isFemale)
    if isFemale then return "vo/npc/female01/pain0" .. math.random(1, 9) .. ".wav" end
    return "vo/npc/male01/pain0" .. math.random(1, 9) .. ".wav"
end

function SWEP:FuckingStun(ply, tims)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    ply:SetMoveType(MOVETYPE_FLYGRAVITY)
    ply:EmitSound(GetSound(ply:isFemale()))
    hook.Run("PlayerStunned", ply, self)
    timer.Create("antistun" .. ply:SteamID(), 1, 1, function()
        if IsValid(ply) then ply:SetMoveType(MOVETYPE_WALK) end
        if IsValid(self) then self.Taser = false end
        hook.Run("PlayerStunCleared", ply, self)
    end)

    net.Start("fucking_stun")
    net.WriteEntity(ply)
    net.WriteDouble(tims)
    net.Broadcast()
end

function SWEP:FuckingOverStun(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    ply:TakeDamage(lia.config.get("Damage"), nil, nil)
    ply:Freeze(true)
    ply:EmitSound(GetSound(ply:isFemale()))
    hook.Run("PlayerOverStunned", ply, self)
    timer.Create("antistun2" .. ply:SteamID(), lia.config.get("StunTime"), 1, function()
        if IsValid(ply) then
            ply:SetMoveType(MOVETYPE_WALK)
            ply:Freeze(false)
        end

        hook.Run("PlayerOverStunCleared", ply, self)
    end)

    net.Start("fucking_stun2")
    net.WriteEntity(ply)
    net.Broadcast()
end

function SWEP:FuckThis(n)
    if IsValid(self.ent) then self.ent:SetTarget(self.Target, self.dist) end
    local help = self.Target and self.Target.HelpEnt
    self.Target = nil
    timer.Simple(n, function()
        if IsValid(self.ent) then
            self.ent:Remove()
            self:CreateHelpingProp()
        end

        if IsValid(self.ent2) then self.ent2:Remove() end
        if IsValid(help) then help:Remove() end
    end)
end

function SWEP:Deploy()
    self:SetWeaponHoldType("pistol")
    self.Power = 100
    self.Taser = nil
    if SERVER and not IsValid(self.ent) then self:CreateHelpingProp() end
    return true
end

function SWEP:Holster()
    self:SetWeaponHoldType("pistol")
    if SERVER then
        self.Target = nil
        if IsValid(self.ent2) then self.ent2:Remove() end
        if IsValid(self.ent) then self:FuckThis(2) end
    end
    return true
end

function SWEP:OnDrop()
    if SERVER then
        self.Target = nil
        if IsValid(self.ent2) then self.ent2:Remove() end
        if IsValid(self.ent) then self.ent:Remove() end
    end
end

function SWEP:OnRemove()
    if SERVER then
        self.Target = nil
        if IsValid(self.ent2) then self.ent2:Remove() end
        if IsValid(self.ent) then self.ent:Remove() end
    end
end

function SWEP:Reload()
    if not self:DefaultReload(ACT_VM_RELOAD) then return end
    if SERVER then
        self:FuckThis(3)
        self:SetNextPrimaryFire(CurTime() + 3)
        self.Laser = false
        self:SetNW2Int("power", 0)
        net.Start("omglaser")
        net.WriteEntity(self)
        net.WriteBit(self.Laser)
        net.Broadcast()
    end

    self.Reloading = true
    self:GetOwner():SetAnimation(PLAYER_RELOAD)
    timer.Simple(2, function()
        if not IsValid(self) then return end
        self.Reloading = false
        self.Power = 100
        self:SetNW2Int("power", self.Power)
        hook.Run("StunGunReloaded", self:GetOwner(), self)
    end)
end

function SWEP:Think()
    if SERVER and IsValid(self.Target) and self.dist and IsValid(self.ent) then if self.ent:GetPos():Distance(self.Target:GetPos()) > self.dist + lia.config.get("MaxDist") then self:FuckThis(10) end end
end

function SWEP:SecondaryAttack()
    self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
    if SERVER and self.Power > 0 then
        timer.Simple(0.6, function()
            if not IsValid(self) then return end
            local owner = self:GetOwner()
            owner:EmitSound("Weapon_Pistol.Empty")
            self.Laser = not self.Laser
            net.Start("omglaser")
            net.WriteEntity(self)
            net.WriteBit(self.Laser)
            net.Broadcast()
            hook.Run("StunGunLaserToggled", owner, self.Laser, self)
        end)
    end
end

function SWEP:PrimaryAttack()
    self.Power = self.Power or 0
    if SERVER and self.LastUpdated + 0.2 < CurTime() then
        self.LastUpdated = CurTime()
        self:SetNW2Int("power", self.Power)
    end

    if self.Power <= 0 then
        if not self.OverPower then
            if SERVER then
                self.Laser = false
                net.Start("omglaser")
                net.WriteEntity(self)
                net.WriteBit(self.Laser)
                net.Broadcast()
                self:FuckingOverStun(self.Target)
            end

            self.OverPower = true
        end
        return
    end

    self.Power = self.Power - 1
    if self:Clip1() <= 0 then
        local owner = self:GetOwner()
        if self.Target then
            owner:EmitSound("Weapon_Pistol.Empty")
            owner:EmitSound("Weapon_SMG1.Empty")
            if not self.Taser then
                self.Taser = true
                self:FuckingStun(self.Target, 0.9)
                hook.Run("StunGunFired", owner, self.Target)
            end
        else
            self:EmitSound("weapons/clipempty_rifle.wav")
            self:SetNextPrimaryFire(CurTime() + 2)
        end
        return
    end

    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:EmitSound(self.Primary.Sound)
    if SERVER then
        local owner = self:GetOwner()
        local target = owner:GetEyeTrace().Entity
        local maxDist = lia.config.get("MaxDist")
        if IsValid(self.ent) and IsValid(target) and target:IsPlayer() and owner:GetPos():Distance(target:GetPos()) <= maxDist then
            self.Target = target
            self.dist = owner:GetPos():Distance(target:GetPos())
            if not IsValid(target.HelpEnt) then self:CreateMarionete(target) end
            local posLocal = target.HelpEnt:WorldToLocal(owner:GetEyeTrace().HitPos)
            constraint.Rope(self.ent, target.HelpEnt, 0, 0, Vector(0.1, 0.1, 0), posLocal, self.dist, 80, 0, 1, "cable/blue_elec", false)
            constraint.Rope(self.ent, target.HelpEnt, 0, 0, Vector(-0.1, -0.1, 0), posLocal, self.dist, 80, 0, 1, "cable/redlaser", false)
            hook.Run("StunGunTethered", owner, target)
        elseif not self.Target then
            self:CreateFakeRope()
        end

        self:SetNextPrimaryFire(CurTime() + 0.5)
    end

    self:TakePrimaryAmmo(1)
    if not self:GetOwner():IsNPC() then self:GetOwner():ViewPunch(Angle(math.Rand(-0.2, -0.1) * self.Primary.Recoil, math.Rand(-0.1, 0.1) * self.Primary.Recoil, 0)) end
    self.LastPrimaryAttack = CurTime()
end

function SWEP:GetViewModelPosition(pos, ang)
    if not self.IronSightsPos then return pos, ang end
    pos = pos + ang:Forward() * -5
    local offset = self.IronSightsPos
    local angMod = Angle(ang.x, ang.y, ang.z)
    angMod:RotateAroundAxis(angMod:Right(), self.IronSightsAng.x)
    angMod:RotateAroundAxis(angMod:Up(), self.IronSightsAng.y)
    angMod:RotateAroundAxis(angMod:Forward(), self.IronSightsAng.z)
    pos = pos + offset.x * angMod:Right() + offset.y * angMod:Forward() + offset.z * angMod:Up()
    return pos, angMod
end

if CLIENT then
    function SWEP:ViewModelDrawn()
        local vm = self:GetOwner():GetViewModel()
        if not IsValid(vm) then return end
        local boneCartridge = vm:LookupBone("cartridge") or 0
        local boneTrigger = vm:LookupBone("Trigger") or 0
        local mCartridge = vm:GetBoneMatrix(boneCartridge)
        local mTrigger = vm:GetBoneMatrix(boneTrigger)
        if mCartridge and mTrigger then
            local pos = mCartridge:GetTranslation()
            local pos2, ang2 = mTrigger:GetTranslation(), mTrigger:GetAngles()
            if self.Laser then
                render.SetMaterial(Material("cable/redlaser"))
                render.DrawBeam(pos, self:GetOwner():GetEyeTrace().HitPos, 2, 0, 12.5, Color(255, 0, 0, 255))
            end

            ang2:RotateAroundAxis(ang2:Forward(), 90)
            ang2:RotateAroundAxis(ang2:Right(), 90)
            cam.Start3D2D(pos2 + ang2:Right() * -1 + ang2:Up() * 3.12 + ang2:Forward() * 0.12, ang2, 0.1)
            self:DrawScreen(0, 0, 65, 123)
            cam.End3D2D()
        end
    end

    function SWEP:DrawScreen(x, y)
        local power = self:GetNW2Int("power", 0)
        local i = power / 10
        draw.RoundedBox(0, x, y, 6, 10, Color(25, 25, 25, 255))
        draw.RoundedBox(0, x + 1, y, 4, math.Clamp(i, 0, 10), Color(255 - power, 10 + power * 2, 25, 255))
    end
end
