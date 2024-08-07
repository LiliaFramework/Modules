﻿local MODULE = MODULE

lia.command.add("permaremove", {
    adminOnly = true,
    privilege = "Remove Map Entities",
    onRun = function(client)
        local entity = client:GetEyeTraceNoCursor().Entity
        local data = MODULE:getData({})
        local mapID = game.GetMap()
        if IsValid(entity) and entity:CreatedByMap() then
            data[#data + 1] = {mapID, entity:MapCreationID()}
            entity:Remove()
            MODULE:setData(data)
            client:notify("Map entity removed.")
        else
            client:notify("This is not a valid map entity")
        end
    end
})
