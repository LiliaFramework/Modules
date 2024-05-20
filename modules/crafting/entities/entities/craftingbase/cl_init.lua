include("shared.lua")
function ENT:Draw()
    self:DrawModel()
end

function ENT:onShouldDrawEntityInfo()
    return true
end

function ENT:onDrawEntityInfo(alpha)
    local position = (self:LocalToWorld(self:OBBCenter()) + self:GetUp() * 16):ToScreen()
    local x, y = position.x, position.y
    lia.util.drawText(self.PrintName, x, y, ColorAlpha(lia.config.Color, alpha), 1, 1, nil, alpha * 0.65)
    lia.util.drawText(self.Purpose, x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "liaSmallFont", alpha * 0.65)
end
