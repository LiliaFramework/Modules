﻿function MODULE:LoadData()
    local data = self:getData({})
    local mapID = game.GetMap()
    if not data then return end
    for _, info in ipairs(data) do
        local map, entID = unpack(info)
        if mapID ~= map then continue end
        for _, entity in ents.Iterator() do
            if IsValid(entity) and entity:CreatedByMap() and entID == entity:MapCreationID() then entity:Remove() end
        end
    end
end
