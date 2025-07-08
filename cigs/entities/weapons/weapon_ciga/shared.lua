SWEP.PrintName = "Marlboro"
SWEP.IconLetter = ""
SWEP.Author = "Samael"
SWEP.Category = "Samael"
SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.ViewModelFOV = 62 --default
SWEP.BounceWeaponIcon = false
SWEP.ViewModel = "models/oldcigshib.mdl"
SWEP.WorldModel = "models/oldcigshib.mdl"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Clipsize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.Clipsize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.DrawAmmo = false
SWEP.HoldType = "slam"
SWEP.cigaID = 1
function SWEP:Deploy()
	self:SetHoldType("slam")
end

function SWEP:SecondaryAttack()
end

function SWEP:Initialize()
	if not self.CigaInitialized then
		self.CigaInitialized = true
		self.VElements = {
			["ciga"] = {
				type = "Model",
				model = self.ViewModel,
				bone = "ValveBiped.Bip01_Spine4",
				rel = "",
				pos = Vector(-7.1, -2.401, 23.377),
				angle = Angle(111.039, 10.519, 0),
				size = Vector(1, 1, 1),
				color = Color(255, 255, 255, 255),
				surpresslightning = false,
				material = "",
				skin = 0,
				bodygroup = {}
			}
		}

		--self.VElements["ciga"].model = self.ViewModel
		self.OldCigaModel = self.ViewModel
		self.ViewModel = "models/weapons/c_slam.mdl"
		self.UseHands = true
		self.ViewModelFlip = true
		self.ShowViewModel = true
		self.ShowWorldModel = true
		self.ViewModelBoneMods = {
			["ValveBiped.Bip01_L_Finger1"] = {
				scale = Vector(1, 1, 1),
				pos = Vector(0, 0, 0),
				angle = Angle(-23.334, -12.223, -32.223)
			},
			["ValveBiped.Bip01_L_Finger12"] = {
				scale = Vector(1, 1, 1),
				pos = Vector(0, 0, 0),
				angle = Angle(0, -21.112, 0)
			},
			["ValveBiped.Bip01_L_Finger4"] = {
				scale = Vector(1, 1, 1),
				pos = Vector(0, 0, 0),
				angle = Angle(0, -65.556, 0)
			},
			["ValveBiped.Bip01_R_UpperArm"] = {
				scale = Vector(1, 1, 1),
				pos = Vector(0, 0, 0),
				angle = Angle(0, 72.222, -41.112)
			},
			["ValveBiped.Bip01_L_Finger0"] = {
				scale = Vector(1, 1, 1),
				pos = Vector(0, 0, 0),
				angle = Angle(10, 1.11, -1.111)
			},
			["Detonator"] = {
				scale = Vector(0.009, 0.009, 0.009),
				pos = Vector(0, 0, 0),
				angle = Angle(0, 0, 0)
			},
			["ValveBiped.Bip01_L_Hand"] = {
				scale = Vector(1, 1, 1),
				pos = Vector(0, 0, 0),
				angle = Angle(-27.778, 1.11, -7.778)
			},
			["Slam_panel"] = {
				scale = Vector(0.009, 0.009, 0.009),
				pos = Vector(0, 0, 0),
				angle = Angle(0, 0, 0)
			},
			["ValveBiped.Bip01_L_Finger2"] = {
				scale = Vector(1, 1, 1),
				pos = Vector(0, 0, 0),
				angle = Angle(0, -47.778, 0)
			},
			["ValveBiped.Bip01_L_Finger3"] = {
				scale = Vector(1, 1, 1),
				pos = Vector(0, 0, 0),
				angle = Angle(0, -43.334, 0)
			},
			["Slam_base"] = {
				scale = Vector(0.009, 0.009, 0.009),
				pos = Vector(0, 0, 0),
				angle = Angle(0, 0, 0)
			},
			["ValveBiped.Bip01_R_Hand"] = {
				scale = Vector(0.009, 0.009, 0.009),
				pos = Vector(0, 0, 0),
				angle = Angle(0, 0, 0)
			}
		}
	end

	if CLIENT then
		-- Create a new table for every weapon instance
		self.VElements = table.FullCopy(self.VElements)
		self.WElements = table.FullCopy(self.WElements)
		self.ViewModelBoneMods = table.FullCopy(self.ViewModelBoneMods)
		self:CreateModels(self.VElements) -- create viewmodels
		self:CreateModels(self.WElements) -- create worldmodels
		-- init view model bone build function
		if IsValid(self:GetOwner()) then
			local vm = self:GetOwner():GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				-- Init viewmodel visibility
				if self.ShowViewModel == nil or self.ShowViewModel then
					vm:SetColor(Color(255, 255, 255, 255))
				else
					-- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255, 255, 255, 1))
					-- ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					-- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")
				end
			end
		end
	end

	if self.Initialize2 then self:Initialize2() end
end

function SWEP:PrimaryAttack()
	if SERVER then cigaUpdate(self:GetOwner(), self.cigaID) end
	self:SetNextPrimaryFire(CurTime() + 0.1)
end

function SWEP:Reload()
end

function SWEP:Holster()
	if SERVER and IsValid(self:GetOwner()) then Releaseciga(self:GetOwner()) end
	if CLIENT and IsValid(self:GetOwner()) then
		local vm = self:GetOwner():GetViewModel()
		if IsValid(vm) then self:ResetBonePositions(vm) end
	end
	return true
end

SWEP.OnDrop = SWEP.Holster
SWEP.OnRemove = SWEP.Holster