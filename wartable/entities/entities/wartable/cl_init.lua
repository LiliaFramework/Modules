function ENT:Draw()
    self:DrawModel()
    if self:GetPos():DistToSqr(LocalPlayer():GetPos()) < 250000 then
        local pos = self:GetPos() + self:GetUp() * self.DisplayVector.z + self:GetRight() * self.DisplayVector.x + self:GetForward() * self.DisplayVector.y
        local ang = self:GetAngles()
        ang:RotateAroundAxis(self:GetRight(), self.DisplayAngle.pitch)
        ang:RotateAroundAxis(self:GetUp(), self.DisplayAngle.yaw)
        ang:RotateAroundAxis(self:GetForward(), self.DisplayAngle.roll)
        cam.Start3D2D(pos, ang, self.DisplayScale)
        self.Panel:PaintManual()
        self.MapHTML:PaintManual()
        cam.End3D2D()
    end
end

function ENT:OnRemove()
    if IsValid(self.Panel) then self.Panel:Remove() end
end

function ENT:SetMap(url)
    if IsValid(self.MapHTML) then self.MapHTML:OpenURL(url) end
end
