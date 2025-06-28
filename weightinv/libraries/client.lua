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