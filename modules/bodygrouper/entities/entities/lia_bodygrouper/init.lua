﻿local MODULE = MODULE
function ENT:Initialize()
    self:SetModel(MODULE.BodyGrouperModel)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
end

function ENT:Use(activator)
    if activator:IsPlayer() then
        net.Start("BodygrouperMenu")
        net.Send(activator)
        self:AddUser(activator)
    end
end