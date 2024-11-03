function MODULE:PlayerUse(client, entity)
    if IsValid(entity) and entity:GetClass() == "prop_ragdoll" and IsValid(entity:getNetVar("player")) and not client:GetNW2Bool("IdCooldown", false) then
        client:binaryQuestion("Do you want to identify this corpse?", "Yes", "No", false, function(choice)
            if choice == 0 then
                self:IdentifyCorpse(client, entity)
            else
                client:notify("You decided not to identify the corpse.")
            end
        end)

        client:SetNW2Bool("IdCooldown", true)
        timer.Simple(5, function() if IsValid(client) then client:SetNW2Bool("IdCooldown", false) end end)
    end
end

function MODULE:IdentifyCorpse(client, corpse)
    local IDTime = self.IdentificationTime or 5
    if IsValid(corpse) and corpse:getNetVar("player") then
        local targetPlayer = corpse:getNetVar("player")
        client:setAction("Identifying corpse...", IDTime)
        client:doStaredAction(corpse, function() client:ChatPrint("This corpse appears to belong to " .. targetPlayer:Nick() .. ".") end, IDTime, function()
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

function MODULE:ShouldSpawnClientRagdoll(client)
    return false
end