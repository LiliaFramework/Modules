function MODULE:saveForceFields()
    local buffer = {}
    for _, v in pairs(ents.FindByClass("lia_forcefield")) do
        buffer[#buffer + 1] = {
            pos = v:GetPos(),
            ang = v:GetAngles(),
            mode = v.mode or 1
        }
    end

    self:setData(buffer)
end

function MODULE:LoadData()
    local buffer = self:getData() or {}
    for _, v in ipairs(buffer) do
        local entity = ents.Create("lia_forcefield")
        entity:SetPos(v.pos)
        entity:SetAngles(v.ang)
        entity:Spawn()
        entity.mode = v.mode or 1
    end
end
