local MODULE = MODULE
function MODULE:DrawCharInfo(_, character, info)
    local tier = tonumber(character:getData("party_tier", 0))
    if self.Tiers[tier] then info[#info + 1] = {self.Tiers[tier], Color(255, 209, 20)} end
end

function MODULE:LoadCharInformation()
    local client = LocalPlayer()
    local character = client:getChar()
    local tier = tonumber(character:getData("party_tier", 0))
    hook.Run("AddTextField", L("generalinfo"), "partytier", L("partyTier"), function() return self.Tiers[tier] end)
end

function MODULE:LoadMainMenuInformation(info, character)
    local tier = tonumber(character:getData("party_tier", 0))
    table.insert(info, L("partyTierDisplay", self.Tiers[tier]))
end