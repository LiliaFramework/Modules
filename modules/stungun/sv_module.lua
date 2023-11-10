-------------------------------------------------------------------------------------------
function MODULE:TasePlayer(ply, target)
    if not ply:IsPlayer() then return end
    if not IsValid(ply:GetActiveWeapon()) then return end
    if ply:GetActiveWeapon():GetClass() ~= "weapon_stungun" then return end
    target:Freeze(true)
    target:SetNoDraw(true)
    target:setRagdolledTase(true, 5, 0)
    target:notify("You have been tased by " .. ply:Nick())
    timer.Simple(
        15,
        function()
            ply:notify("Target is too stunned to react! You have time to tie him up!")
            target:notify("You have been been able to stand up but you are now too stunned to move!")
            target:SetNoDraw(false)
            timer.Simple(
                5,
                function()
                    target:notify("You are now able to move!")
                    ply:notify("Target is now able to move!")
                    target:Freeze(false)
                end
            )
        end
    )
end
-------------------------------------------------------------------------------------------
