local panelMeta = FindMetaTable("Panel")
function MODULE:CreateInventoryPanel(inventory, parent)
    local panel = parent:Add("liaListInventory")
    panel:setInventory(inventory)
    panel:Center()
    return panel
end

function MODULE:getItemStackKey(item)
    local elements = {}
    for key, value in SortedPairs(item.data) do
        elements[#elements + 1] = key
        elements[#elements + 1] = value
    end
    return item.uniqueID .. pon.encode(elements)
end

function MODULE:getItemStacks(inventory)
    local stacks = {}
    local stack, key
    for _, item in SortedPairs(inventory:getItems()) do
        key = self:getItemStackKey(item)
        stack = stacks[key] or {}
        stack[#stack + 1] = item
        stacks[key] = stack
    end
    return stacks
end

function panelMeta:liaListenForInventoryChanges(inventory)
    assert(inventory, "No inventory has been set!")
    local id = inventory:getID()
    self:liaDeleteInventoryHooks(id)
    _LIA_INV_PANEL_ID = (_LIA_INV_PANEL_ID or 0) + 1
    local hookID = "liaInventoryListener" .. _LIA_INV_PANEL_ID
    self.liaHookID = self.liaHookID or {}
    self.liaHookID[id] = hookID
    self.liaToRemoveHooks = self.liaToRemoveHooks or {}
    self.liaToRemoveHooks[id] = {}
    local function listenForInventoryChange(name, panelHook)
        panelHook = panelHook or name
        hook.Add(name, hookID, function(inventory, ...)
            if not IsValid(self) then return end
            if not isfunction(self[panelHook]) then return end
            local args = {...}
            args[#args + 1] = inventory
            self[panelHook](self, unpack(args))
            if name == "InventoryDeleted" and self.deleteInventoryHooks then self:deleteInventoryHooks(id) end
        end)

        table.insert(self.liaToRemoveHooks[id], name)
    end

    listenForInventoryChange("InventoryInitialized")
    listenForInventoryChange("InventoryDeleted")
    listenForInventoryChange("InventoryDataChanged")
    listenForInventoryChange("InventoryItemAdded")
    listenForInventoryChange("InventoryItemRemoved")
    hook.Add("ItemDataChanged", hookID, function(item, key, oldValue, newValue)
        if not IsValid(self) or not inventory.items[item:getID()] then return end
        if not isfunction(self.InventoryItemDataChanged) then return end
        self:InventoryItemDataChanged(item, key, oldValue, newValue, inventory)
    end)

    table.insert(self.liaToRemoveHooks[id], "ItemDataChanged")
end

function panelMeta:liaDeleteInventoryHooks(id)
    if not self.liaHookID then return end
    if id == nil then
        for invID, hookIDs in pairs(self.liaToRemoveHooks) do
            for i = 1, #hookIDs do
                if IsValid(self.liaHookID) then hook.Remove(hookIDs[i], self.liaHookID) end
            end

            self.liaToRemoveHooks[invID] = nil
        end
        return
    end

    if not self.liaHookID[id] then return end
    for i = 1, #self.liaToRemoveHooks[id] do
        hook.Remove(self.liaToRemoveHooks[id][i], self.liaHookID[id])
    end

    self.liaToRemoveHooks[id] = nil
end

hook.Add("CreateMenuButtons", "liaInventory", function(tabs)
    if hook.Run("CanPlayerViewInventory") == false then return end
    tabs[L("inv")] = function(parentPanel)
        local inv = LocalPlayer():getChar():getInv()
        if not inv then return end
        local margin = 10
        local panels = {}
        local mainPanel = inv:show(parentPanel)
        mainPanel:ShowCloseButton(false)
        panels[1] = mainPanel
        for _, item in pairs(inv:getItems()) do
            if item.isBag and hook.Run("CanOpenBagPanel", item) ~= false then
                local bagInv = item:getInv()
                local bagPanel = bagInv:show(parentPanel)
                bagPanel:ShowCloseButton(false)
                panels[#panels + 1] = bagPanel
            end
        end

        local totalW, maxH = 0, 0
        for _, panel in ipairs(panels) do
            totalW = totalW + panel:GetWide()
            maxH = math.max(maxH, panel:GetTall())
        end

        totalW = totalW + margin * (#panels - 1)
        local px, py, pw, ph = parentPanel:GetBounds()
        local x = px + (pw - totalW) * 0.5
        local yCenter = py + ph * 0.5
        for _, panel in ipairs(panels) do
            panel:SetPos(x, yCenter - panel:GetTall() * 0.5)
            x = x + panel:GetWide() + margin
        end

        hook.Add("PostRenderVGUI", "liaInventoryRender", function()
            for _, panel in ipairs(panels) do
                hook.Run("PostDrawInventory", panel, parentPanel)
            end
        end)
    end
end)