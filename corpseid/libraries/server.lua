local function IdentifyCorpse(client, corpse)
    if not IsValid(corpse) then return end
    local targetPlayer = corpse:getNetVar("player")
    if not IsValid(targetPlayer) then return end
    local IDTime = lia.config.get("IdentificationTime", 5)
    client:setAction(L("identifyingCorpse"), IDTime, function() client:ChatPrint(L("identifiedCorpseMessage", targetPlayer:Nick())) end)
end

function MODULE:PlayerUse(client, entity)
    if IsValid(entity) and entity:GetClass() == "prop_ragdoll" and IsValid(entity:getNetVar("player")) and not client:getNetVar("IdCooldown", false) then
        client:binaryQuestion(L("identifyCorpseQuestion"), L("yes"), L("no"), false, function(choice)
            if choice == 0 then
                IdentifyCorpse(client, entity)
            else
                client:notifyLocalized("identifyCorpseDeclined")
            end
        end)

        client:setNetVar("IdCooldown", true)
        timer.Simple(5, function() if IsValid(client) then client:setNetVar("IdCooldown", false) end end)
    end
end

function MODULE:DoPlayerDeath(client)
    local corpse = client:createRagdoll()
    if IsValid(corpse) then
        corpse:setNetVar("ShowCorpseMessage", true)
        corpse:setNetVar("player", client)
    end
end

function MODULE:ShouldSpawnClientRagdoll()
    return false
end