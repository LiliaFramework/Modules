DEFINE_BASECLASS("base_gmodentity")
ENT.PrintName = "War Table"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Lilia"
ENT.RenderGroup = RENDERGROUP_BOTH
function ENT:Clear()
    for _, ent in pairs(self:GetChildren()) do
        ent:Remove()
    end
end

function ENT:Use(activator)
    netstream.Start(activator, "UseWarTable", self, activator:KeyDown(IN_SPEED) and true or false)
end
