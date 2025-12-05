lia.command.add("permaremove", {
    adminOnly = true,
    desc = "permRemoveDesc",
    onRun = function(client)
        local entity = client:GetEyeTraceNoCursor().Entity
        local data = lia.data.get("permaremove", {})
        local mapID = game.GetMap()
        if IsValid(entity) and entity:CreatedByMap() then
            data[#data + 1] = {mapID, entity:MapCreationID()}
            entity:Remove()
            lia.data.set("permaremove", data)
            client:notifyLocalized("permRemoveSuccess")
        else
            client:notifyLocalized("permRemoveInvalid")
        end
    end
})
