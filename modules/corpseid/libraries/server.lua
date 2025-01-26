function MODULE:PlayerUse(client, entity)
    if IsValid(entity) and entity:GetClass() == "prop_ragdoll" and IsValid(entity:getNetVar("player")) and not client:GetNW2Bool("IdCooldown", false) then
        client:binaryQuestion(L("identifyCorpseQuestion"), L("yes"), L("no"), false, function(choice)
            if choice == 0 then
                self:IdentifyCorpse(client, entity)
            else
                client:notify(L("identifyCorpseDeclined"))
            end
        end)

        client:SetNW2Bool("IdCooldown", true)
        timer.Simple(5, function() if IsValid(client) then client:SetNW2Bool("IdCooldown", false) end end)
    end
end

function MODULE:IdentifyCorpse(client, corpse)
    local IDTime = self.IdentificationTime
    if IsValid(corpse) and corpse:getNetVar("player") then
        local targetPlayer = corpse:getNetVar("player")
        client:setAction(L("identifyingCorpse"), IDTime)
        client:doStaredAction(corpse, function() client:ChatPrint(L("identifiedCorpseMessage", targetPlayer:Nick())) end, IDTime, function()
            if IsValid(client) then
                client:setAction()
                client:SetNW2Bool("IdCooldown", false)
                corpse:SetNW2Bool("ShowCorpseMessage", false)
            end
        end)
    end
end

function MODULE:DoPlayerDeath(client)
    local corpse = client:CreateServerRagdoll()
    if IsValid(corpse) then
        corpse:SetNW2Bool("ShowCorpseMessage", true)
        corpse:setNetVar("player", client)
    end
end

function MODULE:ShouldSpawnClientRagdoll()
    return false
end
