--------------------------------------------------------------------------------------------------------
AddCSLuaFile()
--------------------------------------------------------------------------------------------------------
SWEP.Base = "weapon_base"
SWEP.PrintName = "Night Vision Goggles"
SWEP.Author = "Tazmily & Leonheart"
SWEP.Instructions = "Reload to activate night vision."
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.Category = "Lilia"
SWEP.HoldType = "normal"
SWEP.ViewModel = Model("models/weapons/c_arms.mdl")
SWEP.WorldModel = ""
SWEP.HitDistance = 50
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 1
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 5
SWEP.Nightvision = false
SWEP.NextReload = CurTime()
SWEP.Slot = 3
SWEP.SlotPos = 4
--------------------------------------------------------------------------------------------------------
function SWEP:Initialize()
    self:SetWeaponHoldType(self.HoldType)
end

--------------------------------------------------------------------------------------------------------
if SERVER then
    function SWEP:Reload()
        if self.NextReload > CurTime() then return end
        self.NextReload = CurTime() + 2
        local ply = self:GetOwner()
        if self.Nightvision == false then
            self.Nightvision = true
            net.Start("AM_NightvisionOn")
            net.Send(ply)
        elseif self.Nightvision == true then
            self.Nightvision = false
            net.Start("AM_NightvisionOff")
            net.Send(ply)
        end
    end

    function SWEP:OnRemove()
        if self.Nightvision == true then
            self.Nightvision = false
            local ply = self:GetOwner()
            net.Start("AM_NightvisionOff")
            net.Send(ply)
        end
    end
end
--------------------------------------------------------------------------------------------------------
