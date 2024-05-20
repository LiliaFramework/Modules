
ENT.Type = "anim"
ENT.PrintName = "Note"
ENT.Author = "Black Tea"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.Category = "Lilia"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.DrawEntityInfo = true

function ENT:getOwner()
    return self:getNetVar("ownerChar")
end


function ENT:canWrite(client)
    if client then return client:IsAdmin() or client:getChar().id == self:getOwner() end
end

