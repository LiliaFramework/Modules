include("shared.lua")
function ENT:Draw()
    self:DrawModel()
    local position = self:GetPos() + self:GetUp() * -8.7 + self:GetForward() * -3.85 + self:GetRight() * -6
    local color = self:GetLocked() and Color(255, 125, 0) or Color(0, 255, 0)
    local size = 14
    if self:GetErroring() then
        color = Color(255, 0, 0)
        size = 28
    elseif self:GetDetonating() then
        return
    end

    render.SetMaterial(Material("sprites/glow04_noz"))
    render.DrawSprite(position, size, size, color)
end
