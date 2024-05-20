include("shared.lua")
function ENT:onShouldDrawEntityInfo()
    return true
end

function ENT:onDrawEntityInfo(alpha)
    local position = self:LocalToWorld(self:OBBCenter()):ToScreen()
    local x, y = position.x, position.y - 10
    lia.util.drawText("Note", x, y, ColorAlpha(lia.config.Color, alpha), 1, 1, nil, alpha * 0.65)
    lia.util.drawText("It seems something is written on.", x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "liaSmallFont", alpha * 0.65)
end

function ENT:Draw()
    self:DrawModel()
end
