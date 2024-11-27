local MODULE = MODULE
ENT.Type = "anim"
ENT.PrintName = "Model Wardrobe"
ENT.Author = "@liliaplayer"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Lilia"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
if SERVER then
	function ENT:Initialize()
		self:SetModel(MODULE.WardrobeModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local physicsObject = self:GetPhysicsObject()
		if IsValid(physicsObject) then
			physicsObject:EnableMotion(false)
			physicsObject:Sleep()
		end
	end

	function ENT:Use(client)
		local char = client:getChar()
		if not char then return end
		local faction = char:getFaction()
		local models = MODULE.ModelList[faction] or {}
		if not table.IsEmpty(models) then
			net.Start("SeeModelTable")
			net.WriteTable(models)
			net.Send(client)
		else
			client:notify("There are no models available for your faction.")
		end
	end
end