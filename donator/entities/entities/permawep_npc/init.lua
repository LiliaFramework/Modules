local MODULE = MODULE
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
    self:SetModel("models/nada/pms/male/moff.mdl")
    self:SetUseType(SIMPLE_USE)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:DrawShadow(true)
    self:SetSolid(SOLID_OBB)
    self:PhysicsInit(SOLID_OBB)
    self:DropToFloor()
    timer.Simple(0.5, function()
        if IsValid(self) then
            self:SetAnim()
            self:SetPos(self:GetPos() - Vector(0, 0, 3))
        end
    end)
end

function ENT:GiveDonatorWeapons(client)
    local weps = MODULE.DonatorWeapons[client:SteamID64()]
    if weps then
        for _, wep in ipairs(weps) do
            if wep and wep ~= "" then client:Give(wep) end
        end
    end
end

function ENT:Use(client)
    if IsValid(client) and client:IsPlayer() and MODULE.DonatorWeapons[client:SteamID64()] then
        self:GiveDonatorWeapons(client)
        client:notifyLocalized("donatorEnjoyWeapons")
    else
        client:notifyLocalized("noPermanentWeapons")
    end
end

function ENT:SetAnim()
    for k, v in ipairs(self:GetSequenceList()) do
        if v:lower():find("idle") and v ~= "idlenoise" then
            self:ResetSequence(k)
            return
        end
    end

    if self:GetSequenceCount() > 1 then self:ResetSequence(4) end
end
