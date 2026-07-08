local MODULE = MODULE
function MODULE:DrawCharInfo(_, character, info)
    if not character then return end
    local tier = tonumber(character:getPartyTier())
    if self.Tiers[tier] then info[#info + 1] = {self.Tiers[tier], Color(255, 209, 20)} end
end

function MODULE:LoadCharInformation()
    local client = LocalPlayer()
    local character = client:getChar()
    if not character then return end
    hook.Run("AddTextField", L("generalInfo"), "partytier", L("partyTier"), function()
        local currentChar = client:getChar()
        if not currentChar then return L("unknown") end
        return self.Tiers[tonumber(currentChar:getPartyTier())] or L("unknown")
    end)
end

function MODULE:LoadMainMenuInformation(info, character)
    if not character then return end
    local tier = tonumber(character:getPartyTier())
    table.insert(info, L("partyTierDisplay", self.Tiers[tier]))
end
