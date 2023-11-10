--------------------------------------------------------------------------------------------------------
lia.config.WarTableMapURL = lia.config.WarTableMapURL or {}
--------------------------------------------------------------------------------------------------------
include("shared.lua")
--------------------------------------------------------------------------------------------------------
ENT.DisplayScale = 0.1
ENT.DisplayVector = Vector(62, 107.5, 30.1)
ENT.DisplayAngle = Angle(180, 0, 180)
--------------------------------------------------------------------------------------------------------
local mainBG = vgui.Create("DPanel")
mainBG:SetSize(2150, 1250)
local mainBGX, mainBGY = mainBG:GetSize()
mainBG:SetPos(0, 0)
mainBG:SetPaintedManually(true)
mainBG.Paint = function(this, w, h)
    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(0, 0, w, h)
end

--------------------------------------------------------------------------------------------------------
local map = vgui.Create("HTML", mainBG)
map:SetSize(mainBG:GetSize())
map:SetMouseInputEnabled(false)
map:OpenURL("https://cdn.discordapp.com/attachments/1059867063902019677/1073743159017885706/432b60eb74bc53305dc3a5ccc573335c1.png")
--------------------------------------------------------------------------------------------------------
function ENT:Draw()
    self:DrawModel()
    if self:GetPos():DistToSqr(LocalPlayer():GetPos()) < 250000 then
        local pos = self:GetPos() + self:GetUp() * self.DisplayVector.z + self:GetRight() * self.DisplayVector.x + self:GetForward() * self.DisplayVector.y
        local ang = self:GetAngles()
        ang:RotateAroundAxis(self:GetRight(), self.DisplayAngle.pitch)
        ang:RotateAroundAxis(self:GetUp(), self.DisplayAngle.yaw)
        ang:RotateAroundAxis(self:GetForward(), self.DisplayAngle.roll)
        cam.Start3D2D(pos, ang, self.DisplayScale)
        mainBG:PaintManual()
        cam.End3D2D()
    end
end

--------------------------------------------------------------------------------------------------------
function ENT:SetMap(text)
    map:OpenURL(text)
end
--------------------------------------------------------------------------------------------------------
