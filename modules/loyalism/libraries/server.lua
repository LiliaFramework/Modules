local MODULE = MODULE

function MODULE:PlayerLoadedChar()
    self:UpdatePartyTiers()
end

function MODULE:UpdatePartyTiers()
    for _, v in pairs(player.GetAll()) do
        local char = v:getChar()
        if char then
            local tier = char:getData("party_tier", 0)
            char:setData("party_tier", tier, false, player.GetAll())
        end
    end
end
