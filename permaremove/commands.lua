local MODULE = MODULE
lia.command.add("permaremove", {
    adminOnly = true,
    privilege = "Remove Map Entities",
    desc = L("permRemoveDesc"),
    onRun = function(client)
        local entity = client:GetEyeTraceNoCursor().Entity
        local data = MODULE:getData({})
        local mapID = game.GetMap()
        if IsValid(entity) and entity:CreatedByMap() then
            if hook.Run("CanPermaRemoveEntity", client, entity) == false then return end
            data[#data + 1] = {mapID, entity:MapCreationID()}
            entity:Remove()
            lia.log.add(client, "permaremove", entity)
            MODULE:setData(data)
            hook.Run("OnPermaRemoveEntity", client, entity)
            client:notifyLocalized("permRemoveSuccess")
        else
            client:notifyLocalized("permRemoveInvalid")
        end
    end
})
