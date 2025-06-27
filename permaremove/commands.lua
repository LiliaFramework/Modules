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
            data[#data + 1] = {mapID, entity:MapCreationID()}
            entity:Remove()
            MODULE:setData(data)
            client:notifyLocalized("permRemoveSuccess")
        else
            client:notifyLocalized("permRemoveInvalid")
        end
    end
})