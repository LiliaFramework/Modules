--------------------------------------------------------------------------------------------------------
local MODULE = MODULE
--------------------------------------------------------------------------------------------------------
function MODULE:PlayerLoadedChar(client)
    self:UpdatePartyTiers()
end

--------------------------------------------------------------------------------------------------------
function MODULE:UpdatePartyTiers()
    for k, v in pairs(player.GetAll()) do
        local char = v:getChar()
        if char then
            local tier = char:getData("party_tier", 0)
            char:setData("party_tier", tier, false, player.GetAll())
        end
    end
end
--------------------------------------------------------------------------------------------------------
