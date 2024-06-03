AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Use(activator)
    if self.id and MODULE.WritingData[self.id] then netstream.Start(activator, "receiveNote", self.id, MODULE.WritingData[self.id], self:canWrite(activator)) end
end
