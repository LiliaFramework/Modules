function MODULE:getOverrideChars(client)
    return client:getLiliaData("overrideSlots", lia.config.get("MaxCharacters"))
end

function MODULE:getRankChars(client)
    local rank = client:GetUserGroup()
    if self.OverrideCharLimit[rank] then return self.OverrideCharLimit[rank] end
    return lia.config.get("MaxCharacters")
end

function MODULE:GetMaxPlayerChar(client)
    return math.max(lia.config.get("MaxCharacters"), self:getOverrideChars(client), self:getRankChars(client)) + client:GetAdditionalCharSlots()
end
