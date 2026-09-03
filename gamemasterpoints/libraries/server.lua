local MODULE = MODULE
MODULE.tpPoints = MODULE.tpPoints or {}
function MODULE:LoadData()
    self.tpPoints = lia.data.get("TPPoints", {}, false, false)
end

function MODULE:AddPoint(client, name, pos)
    if not name or not pos then
        client:notify("Invalid information provided.")
        return
    end

    table.insert(self.tpPoints, {
        name = name,
        pos = pos,
        sound = "",
        effect = ""
    })

    client:notify(string.format("Teleport point %s added.", name))
    lia.data.set("TPPoints", self.tpPoints, false, false)
end

function MODULE:RemovePoint(client, name)
    if not name then
        client:notify("Invalid information provided.")
        return
    end

    local id, properName
    for k, v in pairs(self.tpPoints) do
        if v.name == name then
            id, properName = k, v.name
            break
        end
    end

    if not id then
        for k, v in pairs(self.tpPoints) do
            if lia.util.stringMatches(v.name, name) then
                id, properName = k, v.name
                break
            end
        end
    end

    if not id then
        client:notify("Teleport point not found.")
        return
    end

    self.tpPoints[id] = nil
    lia.data.set("TPPoints", self.tpPoints, false, false)
    client:notify(string.format("Teleport point %s removed.", properName))
end

function MODULE:RenamePoint(client, name, newName)
    if not name or not newName then
        client:notify("Invalid information provided.")
        return
    end

    local oldName
    for _, v in pairs(self.tpPoints) do
        if v.name == name then
            oldName = v.name
            v.name = newName
            break
        end
    end

    if not oldName then
        for _, v in pairs(self.tpPoints) do
            if lia.util.stringMatches(v.name, name) then
                oldName = v.name
                v.name = newName
                break
            end
        end
    end

    if not oldName then
        client:notify("Teleport point not found.")
        return
    end

    lia.data.set("TPPoints", self.tpPoints, false, false)
    client:notify(string.format("%s renamed to %s.", oldName, newName))
end

function MODULE:UpdateSound(client, name, _, newSound)
    if not name or not newSound then
        client:notify("Invalid information provided.")
        return
    end

    local found
    for _, v in pairs(self.tpPoints) do
        if v.name == name then
            found = true
            v.sound = newSound
            break
        end
    end

    if not found then
        client:notify("Invalid sound path.")
        return
    end

    lia.data.set("TPPoints", self.tpPoints, false, false)
    client:notify(string.format("%s sound updated to %s.", name, newSound))
end

function MODULE:UpdateEffect(client, name, _, newEffect)
    if not name or not newEffect then
        client:notify("Invalid information provided.")
        return
    end

    local found
    for _, v in pairs(self.tpPoints) do
        if v.name == name then
            found = true
            v.effect = newEffect
            break
        end
    end

    if not found then
        client:notify("Invalid particle effect path.")
        return
    end

    lia.data.set("TPPoints", self.tpPoints, false, false)
    client:notify(string.format("%s effect updated to %s.", name, newEffect))
end

function MODULE:MoveToPoint(client, name)
    if not name then
        client:notify("Invalid information provided.")
        return
    end

    local pos, sound, effect, properName
    for _, v in pairs(self.tpPoints) do
        if v.name == name then
            properName, pos, sound, effect = v.name, v.pos, v.sound, v.effect
            break
        end
    end

    if not properName then
        for _, v in pairs(self.tpPoints) do
            if lia.util.stringMatches(v.name, name) then
                properName, pos, sound, effect = v.name, v.pos, v.sound, v.effect
                break
            end
        end
    end

    if not properName then
        client:notify("Teleport point not found.")
        return
    end

    if effect ~= "" then
        local ed = EffectData()
        ed:SetOrigin(client:GetPos())
        util.Effect(effect, ed)
    end

    client:SetPos(pos)
    if sound ~= "" then client:EmitSound(sound) end
    if effect ~= "" then
        local ed = EffectData()
        ed:SetOrigin(client:GetPos())
        util.Effect(effect, ed)
    end

    client:notify(string.format("Moved to %s.", properName))
end

net.Receive("GMTPMove", function(_, client)
    if not client:IsAdmin() then return end
    local name = net.ReadString()
    MODULE:MoveToPoint(client, name)
end)

net.Receive("GMTPNewPoint", function(_, client)
    if not client:IsAdmin() then return end
    local name = net.ReadString()
    MODULE:AddPoint(client, name, client:GetPos())
end)

net.Receive("GMTPUpdateName", function(_, client)
    if not client:IsAdmin() then return end
    local oldName = net.ReadString()
    local newName = net.ReadString()
    MODULE:RenamePoint(client, oldName, newName)
end)

net.Receive("GMTPUpdateSound", function(_, client)
    if not client:IsAdmin() then return end
    local name = net.ReadString()
    local oldSound = net.ReadString()
    local newSound = net.ReadString()
    MODULE:UpdateSound(client, name, oldSound, newSound)
end)

net.Receive("GMTPUpdateEffect", function(_, client)
    if not client:IsAdmin() then return end
    local name = net.ReadString()
    local oldEffect = net.ReadString()
    local newEffect = net.ReadString()
    MODULE:UpdateEffect(client, name, oldEffect, newEffect)
end)

net.Receive("GMTPDelete", function(_, client)
    if not client:IsAdmin() then return end
    local name = net.ReadString()
    MODULE:RemovePoint(client, name)
end)
