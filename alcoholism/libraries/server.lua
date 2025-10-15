local next_think
function MODULE:Think()
    if not next_think then next_think = CurTime() end
    if next_think <= CurTime() then
        for _, client in player.Iterator() do
            local bac = client:getNetVar("lia_alcoholism_bac", 0)
            if bac > 0 then
                hook.Run("PreBACDecrease", client, bac)
                local newBac = math.Clamp(bac - lia.config.get("AlcoholDegradeRate", 5), 0, 100)
                client:setNetVar("lia_alcoholism_bac", newBac)
                hook.Run("BACChanged", client, newBac)
                hook.Run("PostBACDecrease", client, newBac)
            end
        end

        next_think = CurTime() + lia.config.get("AlcoholTickTime", 30)
    end
end

function MODULE:StartCommand(client, cmd)
    if (client.nextDrunkCheck or 0) < CurTime() then
        client.nextDrunkCheck = CurTime() + lia.config.get("AlcoholEffectDelay", 0.03)
        local bac = client:getNetVar("lia_alcoholism_bac", 0)
        if bac > 30 then
            cmd:ClearButtons()
            if (client.nextDrunkSide or 0) < CurTime() then
                client.nextDrunkSide = CurTime() + math.Rand(0.1, 0.3) + bac * 0.01
                client.sideRoll = math.random(-1, 1)
                client.frontRoll = math.random(-1, 1)
            end

            local mult = 1
            if (client.intenseSwerveUntil or 0) > CurTime() then mult = lia.config.get("AlcoholIntenseMultiplier", 2) end
            if client.frontRoll == 1 then
                cmd:SetForwardMove(100000 * mult)
            elseif client.frontRoll == -1 then
                cmd:SetForwardMove(-100000 * mult)
            end

            if client.sideRoll == 1 then
                cmd:SetSideMove(100000 * mult)
            elseif client.sideRoll == -1 then
                cmd:SetSideMove(-100000 * mult)
            end
        end
    end

    local bac = client:getNetVar("lia_alcoholism_bac", 0)
    if bac >= lia.config.get("AlcoholRagdollThreshold", 80) and (client.nextRagdollCheck or 0) < CurTime() then
        client.nextRagdollCheck = CurTime() + math.Rand(lia.config.get("AlcoholRagdollMin", 60), lia.config.get("AlcoholRagdollMax", 120))
        if client:Alive() and not client.liaRagdolled and client:GetVelocity():Length2D() > 10 and math.Rand(0, 100) <= lia.config.get("AlcoholRagdollChance", 35) then client:setRagdolled(true, lia.config.get("AlcoholRagdollDuration", 5)) end
    end
end

function MODULE:BACChanged(client, newBac)
    local last = client.lastBAC or 0
    if newBac > last then client.intenseSwerveUntil = CurTime() + lia.config.get("AlcoholIntenseTime", 5) end
    client.lastBAC = newBac
end

function MODULE:PlayerLoadedChar(client)
    client:resetBAC()
end

function MODULE:PostPlayerLoadout(client)
    client:resetBAC()
end

lia.log.addType("bacIncrease", function(client, amt, newBac) return L("bacIncreaseLog", client:Name(), amt, newBac) end, "Gameplay")
lia.log.addType("bacReset", function(client) return L("bacResetLog", client:Name()) end, "Gameplay")
