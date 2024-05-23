function MODULE:LoadData()
    local savedTable = self:getData() or {}
    for _, v in ipairs(savedTable) do
        local cPlayer = ents.Create(v.class)
        cPlayer:SetPos(v.pos)
        cPlayer:SetAngles(v.ang)
        cPlayer:Spawn()
        cPlayer:Activate()
    end
end

function MODULE:SaveData()
    local savedTable = {}
    for _, v in ipairs(ents.GetAll()) do
        if v:isCassete() then
            table.insert(savedTable, {
                class = v:GetClass(),
                pos = v:GetPos(),
                ang = v:GetAngles()
            })
        end
    end

    self:setData(savedTable)
end
