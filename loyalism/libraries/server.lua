local MODULE = MODULE
function MODULE:PlayerLoadedChar()
    self:UpdatePartyTiers()
end

function MODULE:UpdatePartyTiers()
    hook.Run("PreUpdatePartyTiers")
    for _, ply in player.Iterator() do
        local char = ply:getChar()
        if char then
            local tier = char:getData("party_tier", 0)
            hook.Run("PartyTierApplying", ply, tier)
            char:setData("party_tier", tier, false, player.GetAll())
            hook.Run("PartyTierUpdated", ply, tier)
        else
            hook.Run("PartyTierNoCharacter", ply)
        end
    end

    hook.Run("PostUpdatePartyTiers")
end
