local MODULE = MODULE
function MODULE:PlayerLoadedChar()
    self:UpdatePartyTiers()
end

function MODULE:UpdatePartyTiers()
    hook.Run("PreUpdatePartyTiers")
    for _, ply in player.Iterator() do
        local char = ply:getChar()
        if char then
            local tier = char:getPartyTier()
            hook.Run("PartyTierApplying", ply, tier)
            char:setPartyTier(tier)
            hook.Run("PartyTierUpdated", ply, tier)
        else
            hook.Run("PartyTierNoCharacter", ply)
        end
    end

    hook.Run("PostUpdatePartyTiers")
end