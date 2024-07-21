function MODULE:TasePlayer(client, target)
    if not client:IsPlayer() then return end
    if not IsValid(client:GetActiveWeapon()) then return end
    if client:GetActiveWeapon():GetClass() ~= "weapon_stungun" then return end
    target:Freeze(true)
    target:SetNoDraw(true)
    target:setRagdolled(true, 5, 5, "Recovering Conscience")
    target:notify("You have been tased by " .. client:Nick())
    timer.Simple(15, function()
        client:notify("Target is too stunned to react! You have time to tie him up!")
        target:notify("You have been been able to stand up but you are now too stunned to move!")
        target:SetNoDraw(false)
        timer.Simple(5, function()
            target:notify("You are now able to move!")
            client:notify("Target is now able to move!")
            target:Freeze(false)
        end)
    end)
end
