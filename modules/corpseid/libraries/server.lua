function IdentifyCorpse(client, corpse)
    local IDTime = lia.config.get("IdentificationTime", 5)
    if IsValid(corpse) and corpse:getNetVar("player") then
        local targetPlayer = corpse:getNetVar("player")
        client:setAction(L("identifyingCorpse"), IDTime)
        client:doStaredAction(corpse, function() client:ChatPrint(L("identifiedCorpseMessage", targetPlayer:Nick())) end, IDTime, function()
            if IsValid(client) then
                client:setAction()
                client:setNetVar("IdCooldown", false)
                corpse:setNetVar("ShowCorpseMessage", false)
            end
        end)
    end
end

function MODULE:PlayerUse(client, entity)
    if IsValid(entity) and entity:GetClass() == "prop_ragdoll" and IsValid(entity:getNetVar("player")) and not client:getNetVar("IdCooldown", false) then
        client:binaryQuestion(L("identifyCorpseQuestion"), L("yes"), L("no"), false, function(choice)
            if choice == 0 then
                IdentifyCorpse(client, entity)
            else
                client:notify(L("identifyCorpseDeclined"))
            end
        end)

        client:setNetVar("IdCooldown", true)
        timer.Simple(5, function() if IsValid(client) then client:setNetVar("IdCooldown", false) end end)
    end
end

function MODULE:DoPlayerDeath(client)
    local corpse = client:CreateRagdoll()
    if IsValid(corpse) then
        corpse:setNetVar("ShowCorpseMessage", true)
        corpse:setNetVar("player", client)
    end
end

function MODULE:ShouldSpawnClientRagdoll()
    return false
end