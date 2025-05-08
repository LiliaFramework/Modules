DEFINE_BASECLASS("base_gmodentity")
ENT.PrintName = "War Table"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.IsPersistent = true
ENT.Category = "Lilia"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.DisplayScale = 0.1
ENT.DisplayVector = Vector(62, 107.5, 30.1)
ENT.DisplayAngle = Angle(180, 0, 180)
function ENT:Clear()
    for _, child in pairs(self:GetChildren()) do
        if IsValid(child) then child:Remove() end
    end
end

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/props/cs_office/table_meeting.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
    else
        self.Panel = vgui.Create("DPanel")
        self.Panel:SetScaledSize(1920, 1080)
        self.Panel:SetPaintedManually(true)
        function self.Panel:Paint(w, h)
        end

        self.MapHTML = vgui.Create("HTML", self.Panel)
        self.MapHTML:Dock(FILL)
        self.MapHTML:SetMouseInputEnabled(false)
        self.MapHTML:OpenURL(lia.config.get("URL"))
        function self.MapHTML:Paint(w, h)
        end
    end
end