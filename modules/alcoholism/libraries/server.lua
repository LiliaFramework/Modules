local next_think
function MODULE:Think()
    if not next_think then next_think = CurTime() end
    if next_think <= CurTime() then
        for _, client in player.Iterator() do
            local bac = client:getNetVar("lia_alcoholism_bac", 0)
            if bac > 0 then client:setNetVar("lia_alcoholism_bac", math.Clamp(bac - lia.config.get("AlcoholDegradeRate", 5), 0, 100)) end
        end

        next_think = CurTime() + lia.config.get("AlcoholTickTime", 30)
    end
end

function MODULE:StartCommand(client, cmd)
    if (client.nextDrunkCheck or 0) < CurTime() then
        client.nextDrunkCheck = CurTime() + lia.config.get("AlcoholEffectDelay", 0.03)
        if client:getNetVar("lia_alcoholism_bac", 0) > 30 then
            cmd:ClearButtons()
            if (client.nextDrunkSide or 0) < CurTime() then
                client.nextDrunkSide = CurTime() + math.Rand(0.1, 0.3) + (client:getNetVar("lia_alcoholism_bac", 0) * 0.01)
                client.sideRoll = math.random(-1, 1)
                client.frontRoll = math.random(-1, 1)
            end

            if client.frontRoll == 1 then
                cmd:SetForwardMove(100000)
            elseif client.frontRoll == -1 then
                cmd:SetForwardMove(-100000)
            end

            if client.sideRoll == 1 then
                cmd:SetSideMove(100000)
            elseif client.sideRoll == -1 then
                cmd:SetSideMove(-100000)
            end
        end
    end
end

function MODULE:PlayerLoadedChar(client)
    client:ResetBAC()
end

function MODULE:PostPlayerLoadout(client)
    client:ResetBAC()
end
