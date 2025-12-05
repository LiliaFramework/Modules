include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
function ENT:Use(activator)
    net.Start("UseWarTable")
    net.WriteEntity(self)
    net.WriteBool(activator:KeyDown(IN_SPEED))
    net.Send(activator)
end
