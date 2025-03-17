local MODULE = MODULE
SWEP.PrintName = "Rappel Gear"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Category = "Lilia"
SWEP.Author = "wowm0d"
SWEP.Instructions = "Primary Fire: Attach/Cut Rope"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.ViewModelFOV = 45
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "rpg"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""
SWEP.ViewModel = Model("models/weapons/c_arms_animations.mdl")
SWEP.WorldModel = ""
SWEP.UseHands = false
SWEP.IsAlwaysLowered = true
SWEP.FireWhenLowered = true
SWEP.HoldType = "passive"
function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()
    if not IsFirstTimePredicted() then return end
    local owner = self:GetOwner()
    if not IsValid(owner) or owner:GetMoveType() == MOVETYPE_NOCLIP then return end
    if owner.rappelling then
        MODULE:EndRappel(owner)
    elseif owner:OnGround() then
        MODULE:StartRappel(owner)
    end
end

function SWEP:SecondaryAttack()
end
