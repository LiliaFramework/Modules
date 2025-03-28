﻿local MODULE = MODULE
function MODULE:PostPlayerDeath(client)
    if client.rappelling then self:EndRappel(client) end
end

function MODULE:PlayerLoadout(client)
    if client.rappelling then self:EndRappel(client) end
end

function MODULE:DoAnimationEvent(client)
    if client:getNetVar("forcedSequence") == client:LookupSequence("rappelloop") then return ACT_INVALID end
end

local viewPunchAngle = Angle(7, 0, 0)
function MODULE:OnPlayerHitGround(client, _, _, speed)
    if client.rappelling and client.rappelPos.z - client:GetPos().z > 64 then
        self:EndRappel(client)
        if SERVER then client:EmitSound("npc/combine_soldier/zipline_hitground" .. math.random(2) .. ".wav") end
        if speed >= 196 then client:ViewPunch(viewPunchAngle) end
    end
end

function MODULE:FinishMove(client, moveData)
    if client:HasWeapon("lia_rappel_gear") then
        local onGround = client:OnGround()
        if onGround and not client.wasOnGround then
            client.wasOnGround = true
        elseif not onGround and client.wasOnGround then
            client.wasOnGround = false
            if not client.rappelling and moveData:KeyDown(IN_WALK) and client:GetMoveType() ~= MOVETYPE_NOCLIP then self:StartRappel(client) end
        end
    end
end

function MODULE:Move(client, moveData)
    if client.rappelling then
        local vel = moveData:GetVelocity()
        local dir = (client.rappelPos - client:GetPos()) * 0.1
        vel.x = (vel.x + dir.x) * 0.95
        vel.y = (vel.y + dir.y) * 0.95
        local rappelFalling = false
        if not client:OnGround() and client:EyePos().z < client.rappelPos.z then
            rappelFalling = true
            if moveData:KeyDown(IN_WALK) then
                moveData:SetForwardSpeed(0)
                moveData:SetSideSpeed(0)
                vel.z = math.max(vel.z - 16, -128)
            else
                vel.z = math.max(vel.z - 16, -512)
            end
        end

        moveData:SetVelocity(vel)
        if rappelFalling then
            if SERVER then
                local sequence = client:LookupSequence("rappelloop")
                if sequence ~= -1 then client:setNetVar("forcedSequence", sequence) end
                if not client.oneTimeRappelSound then
                    client.oneTimeRappelSound = true
                    client:EmitSound("npc/combine_soldier/zipline" .. math.random(2) .. ".wav")
                end
            end

            if client:WaterLevel() >= 1 then self:EndRappel(client) end
        else
            if SERVER then
                local sequence = client:LookupSequence("rappelloop")
                if sequence ~= 1 and client:getNetVar("forcedSequence") == sequence then client:setNetVar("forcedSequence", nil) end
            end

            local origin = moveData:GetOrigin()
            if math.Distance(origin.x, origin.y, client.rappelPos.x, client.rappelPos.y) > 256 then self:EndRappel(client) end
        end
    end
end
