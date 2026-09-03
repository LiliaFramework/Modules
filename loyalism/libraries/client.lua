local MODULE = MODULE
function MODULE:DrawCharInfo(_, character, info)
    if not character then return end
    local tier = tonumber(character:getPartyTier())
    if self.Tiers[tier] then
        info[#info + 1] = {
            section = "Identity"
        }

        info[#info + 1] = {
            label = "Party Tier",
            value = self.Tiers[tier]
        }
    end
end

function MODULE:LoadCharInformation()
    local client = LocalPlayer()
    local character = client:getChar()
    if not character then return end
    hook.Run("AddTextField", "generalInfo", "partytier", "Loyalty Tier", function()
        local currentChar = client:getChar()
        if not currentChar then return "unknown" end
        return self.Tiers[tonumber(currentChar:getPartyTier())] or "unknown"
    end)
end

function MODULE:LoadMainMenuInformation(info, character)
    if not character then return end
    local tier = tonumber(character:getPartyTier())
    table.insert(info, string.format("Loyalty Tier: %s", self.Tiers[tier]))
end
