local MODULE = MODULE
function MODULE:PlayerLoadedChar()
    self:UpdatePartyTiers()
end

function MODULE:UpdatePartyTiers()
    for _, ply in player.Iterator() do
        local char = ply:getChar()
        if char then
            local tier = char:getPartyTier()
            char:setPartyTier(tier)
        end
    end
end
