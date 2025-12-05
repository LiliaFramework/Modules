local allowedImageTypes = {".PNG", ".JPG", ".JPEG"}
local function getTableEnt(pos)
    for _, ent in pairs(ents.FindByClass("wartable")) do
        if ent:GetPos():DistToSqr(pos) < 25000 then return ent end
    end
    return nil
end

net.Receive("ClearWarTable", function(_, client)
    local tableEnt = getTableEnt(client:GetPos())
    if not tableEnt then return end
    tableEnt:Clear()
end)

net.Receive("SetWarTableMap", function(_, client)
    local _ = net.ReadEntity()
    local text = net.ReadString()
    local tableEnt = getTableEnt(client:GetPos())
    if not tableEnt then return end
    for _, imageType in pairs(allowedImageTypes) do
        if string.find(text, string.lower(imageType)) then
            net.Start("SetWarTableMap")
            net.WriteEntity(tableEnt)
            net.WriteString(text)
            net.Broadcast()
            break
        end
    end
end)

net.Receive("PlaceWarTableMarker", function(_, client)
    local pos = net.ReadVector()
    local bodygroups = net.ReadTable()
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

net.Receive("RemoveWarTableMarker", function(_, client)
    local ent = net.ReadEntity()
    local tableEnt = getTableEnt(client:GetPos())
    if not tableEnt then return end
    ent:Remove()
end)
