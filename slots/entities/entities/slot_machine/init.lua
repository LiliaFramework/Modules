local MODULE = MODULE
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:SpawnFunction(client, trace)
	local SpawnPos = trace.HitPos + trace.HitNormal * 46
	local entity = ents.Create("slot_machine")
	entity:SetPos(SpawnPos)
	local angles = (entity:GetPos() - client:GetPos()):Angle()
	angles.p = 0
	angles.y = 0
	angles.r = 0
	entity:SetAngles(angles)
	entity:Spawn()
	entity:Activate()
	for _, v in pairs(ents.FindInBox(entity:LocalToWorld(entity:OBBMins()), entity:LocalToWorld(entity:OBBMaxs()))) do
		if string.find(v:GetClass(), "prop") and v:GetModel() == "models/props/slotmachine/slotmachinefinal.mdl" then
			entity:SetPos(v:GetPos())
			entity:SetAngles(v:GetAngles())
			SafeRemoveEntity(v)
			break
		end
	end
	return entity
end

function ENT:Initialize()
	self:SetModel("models/props/slotmachine/slotmachinefinal.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local size = 1.5
	self:SetModelScale(size, 0)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(100)
	end

	for i = 1, 3 do
		local spin = ents.Create("prop_scalable")
		spin:SetPos(self:GetPos() + Vector(-17.5 + (i - 1) * 14, -1, -7))
		spin:SetAngles(self:GetAngles())
		spin:SetModel("models/props/slotmachine/spin_wheel.mdl")
		spin:SetParent(self)
		spin:SetCollisionGroup(COLLISION_GROUP_WORLD)
		spin:SetNotSolid(true)
		spin:Spawn()
		spin:SetSkin(13 - i)
		spin:SetModelScale(size, 0)
		self["spin_" .. i] = spin
	end

	self.IsPlaying = true
end

function ENT:Use(client)
	local character = client:getChar()
	if not self.IsPlaying then return end
	if not character:hasMoney(MODULE.GamblingPrice) then
		client:notify("You don't have enough money!")
		return
	end

	timer.Create("SpinWheels" .. self:EntIndex(), 0, 1, function()
		self.IsPlaying = false
		character:takeMoney(MODULE.GamblingPrice)
		self:EmitSound("ambient/levels/labs/coinslot1.wav", 60, 100)
		self:EmitSound("spin.wav", 100, 100)
		for i = 1, 3 do
			self["spin_" .. i]:SetSkin(0)
		end

		self.SelectOne = true
		self.SelectTwo = true
		self.SelectThree = true
		self.Jackpot = false
		self.Lucky = math.random(1, MODULE.JackpotChance)
		if self.Lucky == math.Round(MODULE.JackpotChance / 2) then
			self.Pick = math.Rand(1, 12)
			self.Jackpot = true
		end

		timer.Create("StopWheels" .. self:EntIndex(), 0.75, 3, function()
			if not self.Jackpot then self.Pick = math.random(1, 12) end
			if self.SelectOne then
				self.spin_1:SetSkin(self.Pick)
				self:EmitSound("drum_stop.wav", 100, 100)
				self.SelectOne = false
				return
			end

			if self.SelectTwo then
				self.spin_2:SetSkin(self.Pick)
				self:EmitSound("drum_stop.wav", 100, 100)
				self.SelectTwo = false
				return
			end

			if self.SelectThree then
				self.spin_3:SetSkin(self.Pick)
				self:EmitSound("drum_stop.wav", 100, 100)
				self.SelectThree = false
			end

			local payout = 0
			for i = 1, 3 do
				local skin = self["spin_" .. i]:GetSkin()
				if skin == 1 or skin == 3 or skin == 4 or skin == 5 or skin == 8 or skin == 9 or skin == 10 or skin == 12 then payout = payout + 5 end
			end

			if self.Jackpot then
				local finalSkin = self.spin_3:GetSkin()
				if finalSkin == 1 or finalSkin == 8 then
					payout = MODULE.TripleBarClover
				elseif finalSkin == 3 or finalSkin == 12 then
					payout = MODULE.SingleBarDollarSign
				elseif finalSkin == 4 or finalSkin == 9 then
					payout = MODULE.Lucky7Diamond
				elseif finalSkin == 5 or finalSkin == 10 then
					payout = MODULE.HorseShoeDoubleBar
				end
			end

			if payout > MODULE.SingleBarDollarSign - 1 then self:EmitSound("jackpot.wav", 100, 100) end
			if payout > 9 then
				self:EmitSound("payout.wav", 100, 100)
				character:giveMoney(payout)
				client:notify("Your payout is " .. payout .. "T")
			end

			self.IsPlaying = true
			self.Jackpot = false
		end)
	end)
end