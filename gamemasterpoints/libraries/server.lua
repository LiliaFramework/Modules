local MODULE = MODULE
MODULE.tpPoints = MODULE.tpPoints or {}
function MODULE:LoadData()
    self.tpPoints = lia.data.get("TPPoints", {}, false, false)
end

function MODULE:AddPoint(client, name, pos)
    if not name or not pos then
        client:notifyLocalized("invalidInfo")
        return
    end

    table.insert(self.tpPoints, {
        name = name,
        pos = pos,
        sound = "",
        effect = ""
    })

    client:notifyLocalized("tpPointAdded", name)
    lia.data.set("TPPoints", self.tpPoints, false, false)
end

function MODULE:RemovePoint(client, name)
    if not name then
        client:notifyLocalized("invalidInfo")
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
        client:notifyLocalized("invalidTPName")
        return
    end

    self.tpPoints[id] = nil
    lia.data.set("TPPoints", self.tpPoints, false, false)
    client:notifyLocalized("tpPointRemoved", properName)
end

function MODULE:RenamePoint(client, name, newName)
    if not name or not newName then
        client:notifyLocalized("invalidInfo")
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
        client:notifyLocalized("invalidTPName")
        return
    end

    lia.data.set("TPPoints", self.tpPoints, false, false)
    client:notifyLocalized("pointRenamed", oldName, newName)
end

function MODULE:UpdateSound(client, name, _, newSound)
    if not name or not newSound then
        client:notifyLocalized("invalidInfo")
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
        client:notifyLocalized("invalidSoundPath")
        return
    end

    lia.data.set("TPPoints", self.tpPoints, false, false)
    client:notifyLocalized("soundUpdated", name, newSound)
end

function MODULE:UpdateEffect(client, name, _, newEffect)
    if not name or not newEffect then
        client:notifyLocalized("invalidInfo")
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
        client:notifyLocalized("invalidEffectPath")
        return
    end

    lia.data.set("TPPoints", self.tpPoints, false, false)
    client:notifyLocalized("effectUpdated", name, newEffect)
end

function MODULE:MoveToPoint(client, name)
    if not name then
        client:notifyLocalized("invalidInfo")
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
        client:notifyLocalized("invalidTPName")
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

    client:notifyLocalized("movedTo", properName)
end

netstream.Hook("GMTPMove", function(client, name)
    if not client:IsAdmin() then return end
    MODULE:MoveToPoint(client, name)
end)

netstream.Hook("GMTPNewPoint", function(client, name)
    if not client:IsAdmin() then return end
    MODULE:AddPoint(client, name, client:GetPos())
end)

netstream.Hook("GMTPUpdateName", function(client, oldName, newName)
    if not client:IsAdmin() then return end
    MODULE:RenamePoint(client, oldName, newName)
end)

netstream.Hook("GMTPUpdateSound", function(client, name, oldSound, newSound)
    if not client:IsAdmin() then return end
    MODULE:UpdateSound(client, name, oldSound, newSound)
end)

netstream.Hook("GMTPUpdateEffect", function(client, name, oldEffect, newEffect)
    if not client:IsAdmin() then return end
    MODULE:UpdateEffect(client, name, oldEffect, newEffect)
end)

netstream.Hook("GMTPDelete", function(client, name)
    if not client:IsAdmin() then return end
    MODULE:RemovePoint(client, name)
end)
