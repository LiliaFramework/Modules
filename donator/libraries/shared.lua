local MODULE = MODULE
local function getOverrideChars(client)
    return client:getLiliaData("overrideSlots", lia.config.get("MaxCharacters"))
end

local function getRankChars(client)
    local rank = client:GetUserGroup()
    if MODULE.OverrideCharLimit[rank] then return MODULE.OverrideCharLimit[rank] end
    return lia.config.get("MaxCharacters")
end

function MODULE:GetMaxPlayerChar(client)
    local maxChars = lia.config.get("MaxCharacters") or 0
    local overrideChars = getOverrideChars(client) or maxChars
    local rankChars = getRankChars(client) or maxChars
    local additional = client:GetAdditionalCharSlots() or 0
    return math.max(maxChars, overrideChars, rankChars) + additional
end