local function IdentifyCorpse(client, corpse)
    if not IsValid(corpse) then return end
    local targetPlayer = corpse:getNetVar("player")
    if not IsValid(targetPlayer) then return end
    local IDTime = lia.config.get("IdentificationTime", 5)
    hook.Run("CorpseIdentifyStarted", client, targetPlayer, corpse)
    client:setAction(L("identifyingCorpse"), IDTime, function()
        client:ChatPrint(L("identifiedCorpseMessage", targetPlayer:Nick()))
        lia.log.add(client, "corpseIdentified", targetPlayer)
        hook.Run("CorpseIdentified", client, targetPlayer, corpse)
    end)
end

function MODULE:PlayerUse(client, entity)
    if IsValid(entity) and entity:GetClass() == "prop_ragdoll" and IsValid(entity:getNetVar("player")) and not client:getNetVar("IdCooldown", false) then
        client:binaryQuestion(L("identifyCorpseQuestion"), L("yes"), L("no"), false, function(choice)
            if choice == 0 then
                hook.Run("CorpseIdentifyBegin", client, entity)
                IdentifyCorpse(client, entity)
            else
                client:notifyLocalized("identifyCorpseDeclined")
                hook.Run("CorpseIdentifyDeclined", client, entity)
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
        hook.Run("CorpseCreated", client, corpse)
    end
end

function MODULE:ShouldSpawnClientRagdoll()
    return false
end

lia.log.addType("corpseIdentified", function(client, target)
    return string.format("%s identified corpse of %s", client:Name(), target:Name())
end, "Gameplay")
