
local SCANNER_SOUNDS = {"npc/scanner/scanner_blip1.wav", "npc/scanner/scanner_scan1.wav", "npc/scanner/scanner_scan2.wav", "npc/scanner/scanner_scan4.wav", "npc/scanner/scanner_scan5.wav", "npc/scanner/combat_scan1.wav", "npc/scanner/combat_scan2.wav", "npc/scanner/combat_scan3.wav", "npc/scanner/combat_scan4.wav", "npc/scanner/combat_scan5.wav", "npc/scanner/cbot_servoscared.wav", "npc/scanner/cbot_servochatter.wav"}

function MODULE:createScanner(client, isClawScanner)
    if IsValid(client.liaScn) then return end
    local entity = ents.Create("lia_scanner")
    if not IsValid(entity) then return end
    for _, scanner in ipairs(ents.FindByClass("lia_scanner")) do
        if scanner:GetPilot() == client then scanner:SetPilot(NULL) end
    end

    entity:SetPos(client:GetPos())
    entity:SetAngles(client:GetAngles())
    entity:SetColor(client:GetColor())
    entity:Spawn()
    entity:Activate()
    entity:setPilot(client)
    if isClawScanner then entity:setClawScanner() end
    entity:setNetVar("player", client)
    client.liaScn = entity
    return entity
end


function MODULE:PlayerSpawn(client)
    if IsValid(client.liaScn) then
        client.liaScn.noRespawn = true
        client.liaScn.spawn = client:GetPos()
        client.liaScn:Remove()
        client.liaScn = nil
        client:SetViewEntity(NULL)
    end
end


function MODULE:PlayerLoadedChar(client)
    net.Start("liaScannerClearPicture")
    net.Send(client)
end


function MODULE:DoPlayerDeath(client)
    if IsValid(client.liaScn) then
        client:AddDeaths(1)
        return false
    end
end


function MODULE:PlayerDeath(client)
    if IsValid(client.liaScn) and client.liaScn.health > 0 then
        client.liaScn:die()
        client.liaScn = nil
    end
end


function MODULE:KeyPress(client, key)
    if IsValid(client.liaScn) and (client.liaScnDelay or 0) < CurTime() then
        local source
        if key == IN_USE then
            source = table.Random(SCANNER_SOUNDS)
            client.liaScnDelay = CurTime() + 1.75
        elseif key == IN_RELOAD then
            source = "npc/scanner/scanner_talk" .. math.random(1, 2) .. ".wav"
            client.liaScnDelay = CurTime() + 10
        elseif key == IN_WALK then
            if client:GetViewEntity() == client.liaScn then
                client:SetViewEntity(NULL)
            else
                client:SetViewEntity(client.liaScn)
            end
        end

        if source then client.liaScn:EmitSound(source) end
    end
end


function MODULE:PlayerNoClip(client)
    if IsValid(client.liaScn) then return false end
end


function MODULE:PlayerUse(client, entity)
    if IsValid(client.liaScn) then return false end
end


function MODULE:CanPlayerReceiveScan(client, photographer)
    return client.isCombine and client:isCombine()
end


function MODULE:PlayerSwitchFlashlight(client, enabled)
    local scanner = client.liaScn
    if not IsValid(scanner) then return end
    if (scanner.nextLightToggle or 0) >= CurTime() then return false end
    scanner.nextLightToggle = CurTime() + 0.5
    local pitch
    if scanner:isSpotlightOn() then
        scanner:disableSpotlight()
        pitch = 240
    else
        scanner:enableSpotlight()
        pitch = 250
    end

    scanner:EmitSound("npc/turret_floor/click1.wav", 50, pitch)
    return false
end


function MODULE:PlayerCanPickupWeapon(client, weapon)
    if IsValid(client.liaScn) then return false end
end


function MODULE:PlayerCanPickupItem(client, item)
    if IsValid(client.liaScn) then return false end
end


function MODULE:PlayerFootstep(client)
    if IsValid(client.liaScn) then return true end
end


function MODULE:PlayerRankChanged(client)
    if IsValid(client.liaScn) then client:Spawn() end
end

