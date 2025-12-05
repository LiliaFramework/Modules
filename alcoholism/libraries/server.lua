-- Alcohol config locals
local AlcoholDegradeRate = 5
local AlcoholTickTime = 30
local AlcoholEffectDelay = 0.03
local AlcoholIntenseMultiplier = 2
local AlcoholRagdollThreshold = 80
local AlcoholRagdollMin = 10
local AlcoholRagdollMax = 15
local AlcoholRagdollChance = 5
local AlcoholRagdollDuration = 5
local AlcoholIntenseTime = 5
local function StartBACDegradation(client)
    if timer.Exists("BAC_Degradation_" .. client:SteamID()) then return end
    timer.Create("BAC_Degradation_" .. client:SteamID(), AlcoholTickTime, 0, function()
        if not IsValid(client) then
            timer.Remove("BAC_Degradation_" .. client:SteamID())
            return
        end

        local bac = client:getLocalVar("bac", 0)
        if bac > 0 then
            local newBac = math.Clamp(bac - AlcoholDegradeRate, 0, 100)
            client:setLocalVar("bac", newBac)
            if newBac <= 0 then timer.Remove("BAC_Degradation_" .. client:SteamID()) end
        else
            timer.Remove("BAC_Degradation_" .. client:SteamID())
        end
    end)
end

local function StopBACDegradation(client)
    timer.Remove("BAC_Degradation_" .. client:SteamID())
end

function MODULE:NetVarChanged(client, cmd)
    -- Only care about player entities and BAC changes
    if IsValid(entity) and entity:IsPlayer() and key == "bac" then
        -- BAC value changed
        if newValue and newValue > 0 and (oldValue == nil or oldValue <= 0) then
            -- BAC became positive, start degradation timer
            StartBACDegradation(entity)
        elseif newValue and newValue <= 0 and oldValue and oldValue > 0 then
            StopBACDegradation(entity)
        end
    end
end

function MODULE:StartCommand(client, cmd)
    if (client.nextDrunkCheck or 0) < CurTime() then
        client.nextDrunkCheck = CurTime() + AlcoholEffectDelay
        local bac = client:getLocalVar("bac", 0)
        if bac > 30 then
            cmd:ClearButtons()
            if (client.nextDrunkSide or 0) < CurTime() then
                client.nextDrunkSide = CurTime() + math.Rand(0.1, 0.3) + bac * 0.01
                client.sideRoll = math.random(-1, 1)
                client.frontRoll = math.random(-1, 1)
            end

            local mult = 1
            if (client.intenseSwerveUntil or 0) > CurTime() then mult = AlcoholIntenseMultiplier end
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

    local bac = client:getLocalVar("bac", 0)
    if bac >= AlcoholRagdollThreshold and (client.nextRagdollCheck or 0) < CurTime() then
        client.nextRagdollCheck = CurTime() + math.Rand(AlcoholRagdollMin, AlcoholRagdollMax)
        if client:Alive() and not client.liaRagdolled and client:GetVelocity():Length2D() > 10 and math.Rand(0, 100) <= AlcoholRagdollChance then client:setRagdolled(true, AlcoholRagdollDuration) end
    end
end

function MODULE:BACChanged(client, newBac)
    local last = client.lastBAC or 0
    if newBac > last then client.intenseSwerveUntil = CurTime() + AlcoholIntenseTime end
    client.lastBAC = newBac
end

function MODULE:PlayerLoadedChar(client)
    client:setLocalVar("bac", 0)
end

function MODULE:PostPlayerLoadout(client)
    client:setLocalVar("bac", 0)
end