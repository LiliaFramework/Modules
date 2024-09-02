local MODULE = MODULE

function MODULE:DrawCharInfo(_, character, info)
    local tier = tonumber(character:getData("party_tier", 0))
    if self.Tiers[tier] then info[#info + 1] = {self.Tiers[tier], Color(255, 209, 20)} end
end
