local MODULE = MODULE
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("ciga")
util.AddNetworkString("cigaArm")
util.AddNetworkString("cigaTalking")
function MODULE.cigaUpdate(ply, cigaID)
    if not ply.cigaCount then ply.cigaCount = 0 end
    if not ply.cantStartciga then ply.cantStartciga = false end
    if ply.cigaCount == 0 and ply.cantStartciga then return end
    ply.cigaID = cigaID
    ply.cigaCount = ply.cigaCount + 1
    hook.Run("PlayerInhaleSmoke", ply, cigaID, ply.cigaCount)
    if ply.cigaCount == 1 then
        hook.Run("PlayerStartSmoking", ply, cigaID)
        lia.log.add(ply, "smokeStart")
        ply.cigaArm = true
        net.Start("cigaArm")
        net.WriteEntity(ply)
        net.WriteBool(true)
        net.Broadcast()
    end

    if ply.cigaCount >= 50 then
        ply.cantStartciga = true
        MODULE.Releaseciga(ply)
    end
end

hook.Add("KeyRelease", "DocigaHook", function(ply, key)
    if key == IN_ATTACK then
        MODULE.Releaseciga(ply)
        ply.cantStartciga = false
    end
end)

function MODULE.Releaseciga(ply)
    if not ply.cigaCount then ply.cigaCount = 0 end
    if ply.cigaCount >= 5 then hook.Run("PlayerPuffSmoke", ply, ply.cigaID, ply.cigaCount) end
    hook.Run("PlayerStopSmoking", ply, ply.cigaID)
    lia.log.add(ply, "smokeStop")
    if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass():sub(1, 11) == "weapon_ciga" then
        if ply.cigaCount >= 5 then
            net.Start("ciga")
            net.WriteEntity(ply)
            net.WriteInt(ply.cigaCount, 8)
            net.WriteInt(ply.cigaID + (ply:GetActiveWeapon().juiceID or 0), 8)
            net.Broadcast()
        end
    end

    if ply.cigaArm then
        ply.cigaArm = false
        net.Start("cigaArm")
        net.WriteEntity(ply)
        net.WriteBool(false)
        net.Broadcast()
    end

    ply.cigaCount = 0
end
