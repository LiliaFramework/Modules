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
    return math.max(lia.config.get("MaxCharacters"), getOverrideChars(client), getRankChars(client)) + client:GetAdditionalCharSlots()
end
