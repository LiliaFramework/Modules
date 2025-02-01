function MODULE:getOverrideChars(client)
    if client:getNetVar("overrideSlots", nil) then
        return client:getNetVar("overrideSlots")
    else
        return lia.config.get("MaxCharacters")
    end
end

function MODULE:getRankChars(client)
    local rank = client:GetUserGroup()
    if self.OverrideCharLimit[rank] then return self.OverrideCharLimit[rank] end
    return lia.config.get("MaxCharacters")
end

function MODULE:GetMaxPlayerChar(client)
    return math.max(lia.config.get("MaxCharacters"), self:getOverrideChars(client), self:getRankChars(client)) + client:GetAdditionalCharSlots()
end
