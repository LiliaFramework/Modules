local MODULE = MODULE
netstream.Hook("ClearWarTable", function(client)
    local tableEnt = getTableEnt(client:GetPos())
    if not tableEnt then return end
    tableEnt:Clear()
end)

netstream.Hook("SetWarTableMap", function(client, _, text)
    local tableEnt = getTableEnt(client:GetPos())
    if not tableEnt then return end
    for _, imageType in pairs(MODULE.allowedImageTypes) do
        print(text, imageType)
        if string.find(text, string.lower(imageType)) then
            netstream.Start(player.GetAll(), "SetWarTableMap", tableEnt, text)
            break
        end
    end
end)

netstream.Hook("PlaceWarTableMarker", function(client, pos, bodygroups)
    local tableEnt = getTableEnt(client:GetPos())
    if not tableEnt then return end
    local tableEntFound = false
    for _, ent in pairs(ents.FindInSphere(pos, 1)) do
        if ent == tableEnt then tableEntFound = true end
    end

    if not tableEntFound then return end
    local marker = ents.Create("prop_physics")
    marker:SetPos(pos)
    marker:SetModel("models/william/war_marker/war_marker.mdl")
    marker:Spawn()
    for k, v in pairs(bodygroups) do
        marker:SetBodygroup(tonumber(k) or 0, tonumber(v) or 0)
    end

    marker:SetParent(tableEnt)
    marker:SetMoveType(MOVETYPE_NONE)
end)

netstream.Hook("RemoveWarTableMarker", function(client, ent)
    local tableEnt = getTableEnt(client:GetPos())
    if not tableEnt then return end
    ent:Remove()
end)
