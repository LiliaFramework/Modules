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
        client:notify(L("targetTooStunned"))
        target:notify(L("targetStunnedMove"))
        target:SetNoDraw(false)
        timer.Simple(5, function()
            if not IsValid(target) then return end
            target:notify(L("nowAbleToMove"))
            client:notify(L("targetAbleToMove"))
            target:Freeze(false)
        end)
    end)
end