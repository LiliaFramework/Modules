local MODULE = MODULE
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
    self:SetModel(self.Model or "models/props_c17/FurnitureTable001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self.receivers = {}
    local physicsObject = self:GetPhysicsObject()
    if IsValid(physicsObject) then physicsObject:Wake() end
    lia.inventory.instance("grid", {
        w = self.InvWidth,
        h = self.InvHeight
    }):next(function(inventory)
        inventory.invType = "grid"
        self:setInventory(inventory)
        inventory.noBags = true
        function inventory:onCanTransfer(client, oldX, oldY, x, y, newInvID)
            return hook.Run("StorageCanTransfer", inventory, client, oldX, oldY, x, y, newInvID)
        end
    end)
end

function ENT:DoCraft(client)
    if not self.AllowedBlueprints then return client:notifyLocalized("notSetup", self.PrintName) end
    if not client:CanCraft() then return client:notifyLocalized("cantCraft") end
    local blueprints, weapons = {}, {}
    local our_inv = self:getInv()
    local our_items = our_inv:getItems()
    local client_inv = client:getChar():getInv()
    if not client_inv then return client:notifyLocalized("cantCraft") end
    for _, v in pairs(our_items) do
        if v.isBlueprint then table.insert(blueprints, v) end
        if v.isWeapon then table.insert(weapons, v) end
    end

    local blueprints_count = #blueprints
    local weapons_count = #weapons
    if blueprints_count > 0 then
        if blueprints_count > 1 then return client:notifyLocalized("tooMany", "blueprints") end
        local blueprint = blueprints[1]
        if not self.AllowedBlueprints[blueprint.uniqueID] then
            local other_tables = {}
            for name, tbl in pairs(CraftingTables) do
                if not tbl then continue end
                for ingredient, allowed in pairs(tbl) do
                    if not allowed then continue end
                    if ingredient ~= blueprint.uniqueID then continue end
                    table.insert(other_tables, name)
                    break
                end
            end
            return client:notifyLocalized("wrongBlueprint", table.concat(other_tables, " or "))
        end

        local items_to_remove = {}
        for _, req in ipairs(blueprint.requirements) do
            local item_count = our_inv:getItemCount(req[1])
            if item_count < req[2] then return client:notifyLocalized("missingIngredients", req[2] - item_count, req[1]) end
            table.insert(items_to_remove, req)
        end

        for _, item in ipairs(items_to_remove) do
            for _ = 1, item[2] do
                local itm = MODULE:HasItem(our_inv, item[1])
                if itm then itm:remove() end
            end
        end

        for _, item in ipairs(blueprint.result) do
            for _ = 1, item[2] do
                local item_definition = lia.item.list[item[1]]
                if not item_definition then return client:notifyLocalized("illegalAccess, %s", "invalid crafting result") end
                local fits = client_inv:canItemFitInInventory(item[1], item_definition.width, item_definition.height)
                if fits then
                    client_inv:add(item[1])
                else
                    lia.item.spawn(item[1], self:GetPos() + self:GetUp() * 15)
                end
            end
        end

        self:EmitSound(self.CraftSound or "player/shove_01.wav")
    elseif weapons_count > 0 and self.WeaponAttachments then
        if weapons_count > 1 then return client:notifyLocalized("tooMany", "weapons") end
        local weapon = weapons[1]
        local attachments = weapon:getData("mod") or {}
        local weaponTable = weapons.GetStored(weapon.class)
        if not weaponTable then return client:notifyLocalized("invalid", "weapon information") end
        local available_attachments = {}
        local attach_table = {}
        local items_to_remove = {}
        for _, v in pairs(attachments) do
            our_inv:add(v)
        end

        for _, v in pairs(our_items) do
            if v.isAttachment then available_attachments[v.uniqueID] = v end
        end

        for category, data in ipairs(weaponTable.Attachments) do
            for _, name in pairs(data.atts) do
                local attachment = available_attachments[name]
                if attachment and not attach_table[category] then
                    attach_table[category] = name
                    table.insert(items_to_remove, attachment)
                end
            end
        end

        for _, v in ipairs(items_to_remove) do
            v:remove()
        end

        if table.Count(attach_table) <= 0 then attach_table = nil end
        weapon:setData("mod", attach_table)
    else
        return client:notifyLocalized("nothingCraftable")
    end
end

function ENT:setInventory(inventory)
    if not inventory then return end
    self:setNetVar("id", inventory:getID())
    inventory:addAccessRule(function(inventory, _, context)
        local client = context.client
        local ent = client.m_nUsingCraftingBench
        if not IsValid(ent) then return end
        if not IsValid(client) then return end
        if ent:getInv() ~= inventory then return end
        local distance = ent:GetPos():Distance(client:GetPos())
        if distance > 128 then return false end
        if ent.receivers[client] then return true end
    end)
end

function ENT:Use(activator)
    local inventory = self:getInv()
    if not inventory or (activator.liaNextOpen or 0) > CurTime() then return end
    if activator:getChar() then
        activator:setAction("Opening...", 1, function()
            if activator:GetPos():DistToSqr(self:GetPos()) <= 10000 then
                if self:IsTableLocked() then
                    self:EmitSound("doors/default_locked.wav")
                    activator:notifyLocalized("lockedTable")
                else
                    activator.m_nUsingCraftingBench = self
                    self.receivers[activator] = true
                    activator.liaBagEntity = self
                    inventory:sync(activator)
                    netstream.Start(activator, "craftingTableOpen", self, inventory:getID())
                end
            end
        end)
    end

    activator.liaNextOpen = CurTime() + 1.5
end

function ENT:OnRemove()
    local index = self:getNetVar("id")
    if lia.shuttingDown or self.liaIsSafe or not index then return end
end

function ENT:SpawnFunction(client, tr, ClassName)
    if not tr.Hit then return end
    local SpawnPos = tr.HitPos + tr.HitNormal * 16
    local ent = ents.Create(ClassName)
    ent:SetPos(SpawnPos)
    ent.Owner = client
    ent:Spawn()
    ent:Activate()
    return ent
end
