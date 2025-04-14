local MODULE = MODULE
local function getOverrideChars(client)
    client = CLIENT and LocalPlayer() or client
    if client and client.getLiliaData then
        local override = client:getLiliaData("overrideSlots", 0)
        return override or 0
    end
    return 0
end

local function getRankChars(client)
    local rank = client:GetUserGroup()
    if MODULE.OverrideCharLimit and MODULE.OverrideCharLimit[rank] then return MODULE.OverrideCharLimit[rank] end
    return lia.config.get("MaxCharacters")
end

function MODULE:GetMaxPlayerChar(client)
    return math.max(lia.config.get("MaxCharacters"), getOverrideChars(client), getRankChars(client)) + client:GetAdditionalCharSlots()
end