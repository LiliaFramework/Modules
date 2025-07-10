include('shared.lua')
if not cigaParticleEmitter then cigaParticleEmitter = ParticleEmitter(Vector(0, 0, 0)) end
function SWEP:DrawWorldModel()
	local ply = self:GetOwner()
	local cigaScale = self.cigaScale or 1
	self:SetModelScale(cigaScale, 0)
	self:SetSubMaterial()
	if IsValid(ply) then
		local modelStr = ply:GetModel():sub(1, 17)
		local isPony = modelStr == "models/ppm/player" or modelStr == "models/mlp/player" or modelStr == "models/cppm/playe"
		local bn = isPony and "LrigScull" or "ValveBiped.Bip01_R_Hand"
		if ply.cigaArmFullyUp then bn = "ValveBiped.Bip01_Head1" end
		local bon = ply:LookupBone(bn) or 0
		local opos = self:GetPos()
		local oang = self:GetAngles()
		local bp, ba = ply:GetBonePosition(bon)
		if bp then opos = bp end
		if ba then oang = ba end
		if ply.cigaArmFullyUp then
			opos = opos + oang:Forward() * 0.95 + oang:Right() * 7 + oang:Up() * 0.035
			oang:RotateAroundAxis(oang:Forward(), -100)
			oang:RotateAroundAxis(oang:Up(), 100)
			opos = opos + oang:Up() * (cigaScale - 1) * -10.25
		else
			oang:RotateAroundAxis(oang:Forward(), 50)
			oang:RotateAroundAxis(oang:Right(), 90)
			opos = opos + oang:Forward() * 2 + oang:Up() * -4.5 + oang:Right() * -2
			oang:RotateAroundAxis(oang:Forward(), 90)
			oang:RotateAroundAxis(oang:Up(), 10)
			opos = opos + oang:Up() * (cigaScale - 1) * -10.25
			opos = opos + oang:Up() * 2
			opos = opos + oang:Right() * 0.5
			opos = opos + oang:Forward() * -1.5
		end

		self:SetupBones()
		local mrt = self:GetBoneMatrix(0)
		if mrt then
			mrt:SetTranslation(opos)
			mrt:SetAngles(oang)
			self:SetBoneMatrix(0, mrt)
		end
	end

	self:DrawModel()
end

function SWEP:GetViewModelPosition(pos, ang)
	local vmpos1 = self.cigaVMPos1 or Vector(18.5, -3.4, -3.25)
	local vmang1 = self.cigaVMAng1 or Vector(170, -180, 20)
	local vmpos2 = self.cigaVMPos2 or Vector(24, -8, -11.2)
	local vmang2 = self.cigaVMAng2 or Vector(120, -180, 150)
	if not LocalPlayer().cigaArmTime then LocalPlayer().cigaArmTime = 0 end
	local lerp = math.Clamp((os.clock() - LocalPlayer().cigaArmTime) * 3, 0, 1)
	if LocalPlayer().cigaArm then lerp = 1 - lerp end
	local topos = Vector(-10, -3.5, -12)
	local toang = Vector(-30, 0, 0)
	local newpos = LerpVector(lerp, topos, Vector(0, 0, 0))
	local vecang = LerpVector(lerp, toang, Vector(0, 0, 0))
	local newang = Angle(vecang.x, vecang.y, vecang.z)
	pos, ang = LocalToWorld(newpos, newang, pos, ang)
	return pos, ang
end

sound.Add({
	name = "ciga_inhale",
	channel = CHAN_WEAPON,
	volume = 0.24,
	level = 60,
	pitch = {95},
	sound = "cigainhale.wav"
})

net.Receive("ciga", function()
	local ply = net.ReadEntity()
	local amt = net.ReadInt(8)
	local fx = net.ReadInt(8)
	if not IsValid(ply) then return end
	if amt >= 50 then
		ply:EmitSound("cigacough1.wav", 90)
		for i = 1, 200 do
			local d = i + 10
			if i > 140 then d = d + 150 end
			timer.Simple((d - 1) * 0.003, function() MODULE.ciga_do_pulse(ply, 1, 100, fx) end)
		end
		return
	elseif amt >= 35 then
		ply:EmitSound("cigabreath2.wav", 75, 100, 0.7)
	elseif amt >= 10 then
		ply:EmitSound("cigabreath1.wav", 70, 130 - math.min(100, amt * 2), 0.4 + amt * 0.005)
	end

	for i = 1, amt * 2 do
		timer.Simple((i - 1) * 0.02, function() MODULE.ciga_do_pulse(ply, math.floor((amt * 2 - i) / 10), fx == 2 and 100 or 0, fx) end)
	end
end)

net.Receive("cigaArm", function()
	local ply = net.ReadEntity()
	local z = net.ReadBool()
	if not IsValid(ply) then return end
	if ply.cigaArm ~= z then
		if z then
			timer.Simple(0.3, function() if IsValid(ply) and ply.cigaArm then ply:EmitSound("ciga_inhale") end end)
		else
			ply:StopSound("ciga_inhale")
		end

		ply.cigaArm = z
		ply.cigaArmTime = os.clock()
		local m = z and 1 or 0
		for i = 0, 9 do
			timer.Simple(i / 30, function() MODULE.ciga_interpolate_arm(ply, math.abs(m - (9 - i) / 10), z and 0 or 0.2) end)
		end
	end
end)

net.Receive("cigaTalking", function()
	local ply = net.ReadEntity()
	if IsValid(ply) then ply.cigaTalkingEndtime = net.ReadFloat() end
end)

function MODULE.ciga_interpolate_arm(ply, mult, mouth_delay)
	if not IsValid(ply) then return end
	if mouth_delay > 0 then
		timer.Simple(mouth_delay, function() if IsValid(ply) then ply.cigaMouthOpenAmt = mult end end)
	else
		ply.cigaMouthOpenAmt = mult
	end

	local b1 = ply:LookupBone("ValveBiped.Bip01_R_Upperarm")
	local b2 = ply:LookupBone("ValveBiped.Bip01_R_Forearm")
	if not b1 or not b2 then return end
	ply:ManipulateBoneAngles(b1, Angle(20 * mult, -62 * mult, 10 * mult))
	ply:ManipulateBoneAngles(b2, Angle(-5 * mult, -10 * mult, 0))
	ply.cigaArmFullyUp = mult == 1
end

hook.Add("InitPostEntity", "cigaMouthMoveSetup", function()
	timer.Simple(1, function()
		if ciga_OriginalMouthMove then return end
		ciga_OriginalMouthMove = GAMEMODE.MouthMoveAnimation
		function GAMEMODE:MouthMoveAnimation(ply)
			if (ply.cigaMouthOpenAmt or 0) == 0 and (ply.cigaTalkingEndtime or 0) < CurTime() then return ciga_OriginalMouthMove(self, ply) end
			local flexCount = ply:GetFlexNum() - 1
			if flexCount <= 0 then return end
			for i = 0, flexCount - 1 do
				local name = ply:GetFlexName(i)
				if name == "jaw_drop" or name == "right_part" or name == "left_part" or name == "right_mouth_drop" or name == "left_mouth_drop" then ply:SetFlexWeight(i, math.max((ply.cigaMouthOpenAmt or 0) * 0.5, math.Clamp(((ply.cigaTalkingEndtime or 0) - CurTime()) * 3, 0, 1) * math.Rand(0.1, 0.8))) end
			end
		end
	end)
end)

function MODULE.ciga_do_pulse(ply, amt, _, fx)
	if not IsValid(ply) then return end
	if ply:WaterLevel() == 3 then return end
	local attachid = ply:LookupAttachment("eyes")
	cigaParticleEmitter:SetPos(LocalPlayer():GetPos())
	local angpos = ply:GetAttachment(attachid) or {
		Ang = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	}

	local fwd, pos
	if ply ~= LocalPlayer() then
		fwd = (angpos.Ang:Forward() - angpos.Ang:Up()):GetNormalized()
		pos = angpos.Pos + fwd * 3.5
	else
		fwd = ply:GetAimVector():GetNormalized()
		pos = ply:GetShootPos() + fwd * 1.5 + gui.ScreenToVector(ScrW() / 2, ScrH()) * 5
	end

	fwd = ply:GetAimVector():GetNormalized()
	for i = 1, amt do
		if not IsValid(ply) then return end
		local particle = cigaParticleEmitter:Add(string.format("particle/smokesprites_00%02d", math.random(7, 16)), pos)
		if particle then
			local dir = VectorRand():GetNormalized() * (amt + 5) / 10
			local vel = ply:GetVelocity() * 0.25 + (fwd * 9 + dir):GetNormalized() * math.Rand(50, 80) * (amt + 1) * 0.2
			MODULE.ciga_do_particle(particle, vel, fx)
		end
	end
end

function MODULE.ciga_do_particle(particle, vel, fx)
	particle:SetColor(255, 255, 255, 255)
	if fx == 3 then particle:SetColor(100, 100, 100, 100) end
	if fx >= 4 then
		local c = JuicycigaJuices[fx - 3].color or HSVToColor(math.random(0, 359), 1, 1)
		particle:SetColor(c.r, c.g, c.b, 255)
	end

	local mega = (fx == 2 and 4 or 1) * 0.3
	particle:SetVelocity(vel * mega)
	particle:SetGravity(Vector(0, 0, 1.5))
	particle:SetLifeTime(0)
	particle:SetDieTime(math.Rand(80, 100) * 0.11 * mega)
	particle:SetStartSize(3 * mega)
	particle:SetEndSize(40 * mega * mega)
	particle:SetStartAlpha(150)
	particle:SetEndAlpha(0)
	particle:SetCollide(true)
	particle:SetBounce(0.25)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetRollDelta(0.01 * math.Rand(-40, 40))
	particle:SetAirResistance(50)
end

matproxy.Add({
	name = "cigaTankColor",
	init = function(self, _, values) self.ResultTo = values.resultvar end,
	bind = function(self, mat, ent)
		if not IsValid(ent) then return end
		if ent:GetClass() == "viewmodel" then
			ent = ent:GetOwner()
			if not IsValid(ent) or not ent:IsPlayer() then return end
			ent = ent:GetActiveWeapon()
			if not IsValid(ent) then return end
		end

		local v = ent.cigaTankColor or Vector(0.3, 0.3, 0.3)
		if v == Vector(-1, -1, -1) then
			local c = HSVToColor((CurTime() * 60) % 360, 0.9, 0.9)
			v = Vector(c.r, c.g, c.b) / 255.0
		end

		mat:SetVector(self.ResultTo, v)
	end
})

matproxy.Add({
	name = "cigaAccentColor",
	init = function(self, _, values) self.ResultTo = values.resultvar end,
	bind = function(self, mat, ent)
		if not IsValid(ent) then return end
		local o = ent:GetOwner()
		if ent:GetClass() == "viewmodel" then
			if not IsValid(o) or not o:IsPlayer() then return end
			ent = o:GetActiveWeapon()
			if not IsValid(ent) then return end
		end

		local special = false
		local col = ent.cigaAccentColor or special and Vector(1, 0.8, 0) or Vector(1, 1, 1)
		if col == Vector(-1, -1, -1) then
			col = Vector(1, 1, 1)
			if IsValid(o) then col = o:GetWeaponColor() end
		end

		mat:SetVector(self.ResultTo, col)
	end
})

if CLIENT then
	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		local vm = self:GetOwner():GetViewModel()
		if not IsValid(vm) or not self.VElements then return end
		self:UpdateBonePositions(vm)
		if not self.vRenderOrder then
			self.vRenderOrder = {}
			for _, key in pairs(self.VElements) do
				local v = self.VElements[key]
				if v.type == "Model" then
					table.insert(self.vRenderOrder, 1, key)
				elseif v.type == "Sprite" or v.type == "Quad" then
					table.insert(self.vRenderOrder, key)
				end
			end
		end

		for _, name in ipairs(self.vRenderOrder) do
			local v = self.VElements[name]
			if not v then
				self.vRenderOrder = nil
				break
			end

			if v.hide then continue end
			if v.type == "Model" and IsValid(v.modelEnt) then
				local pos, ang = self:GetBoneOrientation(self.VElements, v, vm)
				if not pos then
					self.vRenderOrder = nil
					break
				end

				v.modelEnt:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				local matrix = Matrix()
				matrix:Scale(v.size)
				v.modelEnt:EnableMatrix("RenderMultiply", matrix)
				if v.material == "" then
					v.modelEnt:SetMaterial("")
				elseif v.modelEnt:GetMaterial() ~= v.material then
					v.modelEnt:SetMaterial(v.material)
				end

				if v.skin and v.modelEnt:GetSkin() ~= v.skin then v.modelEnt:SetSkin(v.skin) end
				if v.bodygroup then
					for _, bg in pairs(v.bodygroup) do
						if v.modelEnt:GetBodygroup(_) ~= bg then v.modelEnt:SetBodygroup(_, bg) end
					end
				end

				if v.surpresslightning then render.SuppressEngineLighting(true) end
				render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
				render.SetBlend(v.color.a / 255)
				v.modelEnt:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				if v.surpresslightning then render.SuppressEngineLighting(false) end
			elseif v.type == "Sprite" and v.spriteMaterial then
				local pos, ang = self:GetBoneOrientation(self.VElements, v, vm)
				if not pos then
					self.vRenderOrder = nil
					break
				end

				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(v.spriteMaterial)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
			elseif v.type == "Quad" and v.draw_func then
				local pos, ang = self:GetBoneOrientation(self.VElements, v, vm)
				if not pos then
					self.vRenderOrder = nil
					break
				end

				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				cam.Start3D2D(drawpos, ang, v.size)
				v.draw_func(self)
				cam.End3D2D()
			end
		end
	end

	function SWEP:GetBoneOrientation(basetab, tab, ent, bone_override)
		if tab.rel and tab.rel ~= "" then
			local rel = basetab[tab.rel]
			local pos, ang = self:GetBoneOrientation(basetab, rel, ent)
			if not pos then return end
			pos = pos + ang:Forward() * rel.pos.x + ang:Right() * rel.pos.y + ang:Up() * rel.pos.z
			ang:RotateAroundAxis(ang:Up(), rel.angle.y)
			ang:RotateAroundAxis(ang:Right(), rel.angle.p)
			ang:RotateAroundAxis(ang:Forward(), rel.angle.r)
			return pos, ang
		end

		local bone = ent:LookupBone(bone_override or tab.bone)
		if not bone then return end
		local m = ent:GetBoneMatrix(bone)
		if not m then return end
		local pos, ang = m:GetTranslation(), m:GetAngles()
		if IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() and ent == self:GetOwner():GetViewModel() and self.ViewModelFlip then ang.r = -ang.r end
		return pos, ang
	end

	function SWEP:CreateModels(tab)
		if not tab then return end
		for _, v in pairs(tab) do
			if v.type == "Model" and v.model and v.model ~= "" and (not IsValid(v.modelEnt) or v.createdModel ~= v.model) and string.find(v.model, ".mdl") and file.Exists(v.model, "GAME") then
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if IsValid(v.modelEnt) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
			elseif v.type == "Sprite" and v.sprite and v.sprite ~= "" and (not v.spriteMaterial or v.createdSprite ~= v.sprite) and file.Exists("materials/" .. v.sprite .. ".vmt", "GAME") then
				local name = v.sprite .. "-"
				local params = {
					["$basetexture"] = v.sprite
				}

				local tocheck = {"nocull", "additive", "vertexalpha", "vertexcolor", "ignorez"}
				for _, flag in ipairs(tocheck) do
					if v[flag] then
						params["$" .. flag] = 1
						name = name .. "1"
					else
						name = name .. "0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name, "UnlitGeneric", params)
			end
		end
	end

	local allbones
	local hasGarryFixedBoneScalingYet = false
	function SWEP:UpdateBonePositions(vm)
		if not vm:GetBoneCount() then return end
		local loopthrough = self.ViewModelBoneMods
		if not hasGarryFixedBoneScalingYet then
			allbones = {}
			for i = 0, vm:GetBoneCount() do
				local bonename = vm:GetBoneName(i)
				allbones[bonename] = self.ViewModelBoneMods[bonename] or {
					scale = Vector(1, 1, 1),
					pos = Vector(0, 0, 0),
					angle = Angle(0, 0, 0)
				}
			end

			loopthrough = allbones
		end

		for k, v in pairs(loopthrough) do
			local bone = vm:LookupBone(k)
			if not bone then continue end
			local scale, pos, ang = v.scale, v.pos, v.angle
			if not hasGarryFixedBoneScalingYet then
				local ms, cur = Vector(1, 1, 1), vm:GetBoneParent(bone)
				while cur >= 0 do
					ms = ms * (loopthrough[vm:GetBoneName(cur)].scale or Vector(1, 1, 1))
					cur = vm:GetBoneParent(cur)
				end

				scale = scale * ms
			end

			if vm:GetManipulateBoneScale(bone) ~= scale then vm:ManipulateBoneScale(bone, scale) end
			if vm:GetManipulateBoneAngles(bone) ~= ang then vm:ManipulateBoneAngles(bone, ang) end
			if vm:GetManipulateBonePosition(bone) ~= pos then vm:ManipulateBonePosition(bone, pos) end
		end
	end

	function SWEP:ResetBonePositions(vm)
		if not vm:GetBoneCount() then return end
		for i = 0, vm:GetBoneCount() do
			vm:ManipulateBoneScale(i, Vector(1, 1, 1))
			vm:ManipulateBoneAngles(i, Angle(0, 0, 0))
			vm:ManipulateBonePosition(i, Vector(0, 0, 0))
		end
	end
end