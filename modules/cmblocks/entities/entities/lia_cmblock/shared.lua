local MODULE = MODULE
ENT.Type = "anim"
ENT.PrintName = "Combine Lock"
ENT.Category = "HL2 RP"
ENT.Author = "@liliaplayer > Discord"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "Locked")
    self:NetworkVar("Bool", 1, "Erroring")
    self:NetworkVar("Bool", 2, "Detonating")
end

function ENT:SpawnFunction(client, trace)
    local door = trace.Entity
    if not IsValid(door) or not door:isDoor() or IsValid(door.lock) then return client:notifyLocalized("dNotValid") end
    local position, angles = self:getLockPos(client, door)
    local entity = ents.Create("lia_cmblock")
    entity:SetPos(trace.HitPos)
    entity:Spawn()
    entity:Activate()
    entity:setDoor(door, position, angles)
    MODULE:SaveData()
    return entity
end
