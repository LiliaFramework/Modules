lia.command.add("permaremove", {
    adminOnly = true,
    desc = "permRemoveDesc",
    onRun = function(client)
        local entity = client:GetEyeTraceNoCursor().Entity
        local data = lia.data.get("permaremove", {})
        local mapID = game.GetMap()
        if IsValid(entity) and entity:CreatedByMap() then
            if hook.Run("CanPermaRemoveEntity", client, entity) == false then return end
            data[#data + 1] = {mapID, entity:MapCreationID()}
            entity:Remove()
            lia.log.add(client, "permaremove", entity)
            lia.data.set("permaremove", data)
            hook.Run("OnPermaRemoveEntity", client, entity)
            client:notifyLocalized("permRemoveSuccess")
        else
            client:notifyLocalized("permRemoveInvalid")
        end
    end
})