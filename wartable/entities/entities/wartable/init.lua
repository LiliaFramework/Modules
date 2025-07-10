include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
function ENT:Use(activator)
    netstream.Start(activator, "UseWarTable", self, activator:KeyDown(IN_SPEED))
end
