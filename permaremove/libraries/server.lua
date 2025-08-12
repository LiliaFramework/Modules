﻿function MODULE:LoadData()
    if not SERVER then return end
    local data = lia.data.get("permaremove", {})
    local mapID = game.GetMap()
    if not data then return end
    for _, info in ipairs(data) do
        local map, entID = unpack(info)
        if mapID ~= map then continue end
        for _, entity in ents.Iterator() do
            if IsValid(entity) and entity:CreatedByMap() and entID == entity:MapCreationID() then
                hook.Run("OnPermaRemoveLoaded", entity)
                entity:Remove()
            end
        end
    end
end

lia.log.addType("permaremove", function(client, entity) return L("permRemoveLog", client:Name(), tostring(entity)) end, "Player")