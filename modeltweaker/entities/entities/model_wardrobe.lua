ENT.Type = "anim"
ENT.PrintName = "Model Wardrobe"
ENT.Author = "@liliaplayer"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Lilia"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
if SERVER then
    function ENT:Initialize()
        self:SetModel(lia.config.get("ModelTweakerModel"))
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
        local class = char:getClass()
        local models = {}
        if lia.config.get("WardrobeEnableFactionModels", true) then
            local factionModels = lia.faction.indices[faction] and lia.faction.indices[faction].models or {}
            for _, m in ipairs(factionModels) do
                table.insert(models, m)
            end
        end

        if lia.config.get("WardrobeEnableClassModels", true) then
            local classModels = lia.class.list[class] and lia.class.list[class].models or {}
            for _, m in ipairs(classModels) do
                table.insert(models, m)
            end
        end

        if not table.IsEmpty(models) then
            net.Start("SeeModelTable")
            net.WriteTable(models)
            net.Send(client)
       else
            client:notifyLocalized("wardrobeNoModels")
       end
    end
end