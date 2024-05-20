netstream.Hook("craftingTableOpen", function(entity, index)
    local inventory = lia.inventory.instances[index]
    if not IsValid(entity) or not inventory then return end
    local inv1 = LocalPlayer():getChar():getInv():show()
    inv1:ShowCloseButton(false)
    inv1:SetDraggable(false)
    local inv2 = inventory:show()
    inv2:ShowCloseButton(true)
    inv2:SetTitle(entity.PrintName)
    inv2:SetDraggable(false)
    inv2.OnClose = function()
        if IsValid(inv1) then inv1:Remove() end
        netstream.Start("invExit")
    end

    local actPanel = vgui.Create("DPanel")
    actPanel:SetDrawOnTop(true)
    actPanel:SetSize(100, inv2:GetTall())
    actPanel.Think = function(this)
        if not inv2 or not inv2:IsValid() or not inv2:IsVisible() then
            this:Remove()
            return
        end

        local x, y = inv2:GetPos()
        this:SetPos(x - this:GetWide() - 5, y)
    end

    local btn = actPanel:Add("DButton")
    btn:Dock(TOP)
    btn:SetText(L"Craft")
    btn:SetColor(color_white)
    btn:DockMargin(5, 5, 5, 0)
    function btn.DoClick()
        netstream.Start("doCraft", entity, v)
    end

    local middle = (inv1:GetWide() + inv2:GetWide()) / 2
    local current = inv2:GetWide() + inv1:GetWide() / 2
    local new = current - middle
    inv1:MoveBy(new, 0, 0, 0, -1)
    inv2:MoveLeftOf(inv1, 4)
    inv2:MoveBy(new, 0, 0, 0, -1)
    lia.gui["inv" .. index] = inv2
end)

netstream.Hook("openTempStorage", function(entity, index)
    local inventory = lia.inventory.instances[index]
    if IsValid(entity) and inventory then
        local inv1 = LocalPlayer():getChar():getInv():show()
        inv1:ShowCloseButton(false)
        inv1:SetDraggable(false)
        local inv2 = inventory:show()
        inv2:ShowCloseButton(true)
        inv2:SetTitle(entity.PrintName)
        inv2:SetDraggable(false)
        inv2.OnClose = function()
            if IsValid(inv1) then inv1:Remove() end
            netstream.Start("invExit")
        end

        local middle = (inv1:GetWide() + inv2:GetWide()) / 2
        local current = inv2:GetWide() + inv1:GetWide() / 2
        local new = current - middle
        inv1:MoveBy(new, 0, 0, 0, -1)
        inv2:MoveLeftOf(inv1, 4)
        inv2:MoveBy(new, 0, 0, 0, -1)
        lia.gui["inv" .. index] = inv2
    end
end)
