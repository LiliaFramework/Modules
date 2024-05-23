dying_storages = dying_storages or {}
function MODULE:SaveData()
    local to_save = {}
    for _, v in ipairs(ents.GetAll()) do
        if not v.IsCraftingTable then continue end
        to_save[#to_save + 1] = {
            class = v:GetClass(),
            pos = v:GetPos(),
            ang = v:GetAngles(),
            id = v:getNetVar("id", 0)
        }
    end

    self:setData(to_save)
end

function MODULE:LoadData()
    for _, v in ipairs(ents.GetAll()) do
        if v.IsCraftingTable then v:Remove() end
    end

    local to_load = self:getData() or {}
    for _, v in ipairs(to_load) do
        local crafting_table = ents.Create(v.class)
        lia.inventory.loadByID(v.id):next(function(inventory)
            if not inventory then return end
            crafting_table:SetPos(v.pos)
            crafting_table:SetAngles(v.ang)
            crafting_table:Spawn()
            crafting_table:Activate()
            crafting_table:setInventory(inventory)
        end)
    end
end

function MODULE:Think()
    local t = CurTime()
    for _, storage in ipairs(dying_storages) do
        if not IsValid(storage) then continue end
        if storage.die > t then continue end
        table.RemoveByValue(dying_storages, storage)
        storage:Remove()
    end
end
