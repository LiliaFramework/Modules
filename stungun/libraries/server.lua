function MODULE:TasePlayer(client, target)
    if not client:IsPlayer() then return end
    if not IsValid(client:GetActiveWeapon()) then return end
    if client:GetActiveWeapon():GetClass() ~= "weapon_stungun" then return end
    target:Freeze(true)
    target:SetNoDraw(true)
    target:setRagdolled(true, 5, 5, "Recovering Conscience")
    target:notify(L("tasedBy", client:getChar():getDisplayedName(target)))
    timer.Simple(15, function()
        if not IsValid(target) then return end
        client:notifyLocalized("targetTooStunned")
        target:notifyLocalized("targetStunnedMove")
        target:SetNoDraw(false)
        timer.Simple(5, function()
            if not IsValid(target) then return end
            target:notifyLocalized("nowAbleToMove")
            client:notifyLocalized("targetAbleToMove")
            target:Freeze(false)
        end)
    end)
end