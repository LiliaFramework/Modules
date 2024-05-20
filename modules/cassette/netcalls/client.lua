
net.Receive("cOpen", function(len, client)
    local entity = net.ReadType()
    local index = net.ReadUInt(32)
    local inventory = lia.item.inventories[index]
    local inventory2 = LocalPlayer():getChar():getInv()
    local playerInv = inventory2:show()
    playerInv:SetTitle("Player Inventory")
    playerInv:ShowCloseButton(false)
    local cInv = inventory:show()
    cInv:ShowCloseButton(true)
    cInv:SetTitle("")
    cInv:MoveLeftOf(playerInv, 4)
    cInv.OnClose = function(this)
        if IsValid(playerInv) and not IsValid(lia.gui.menu) then playerInv:Remove() end
        netstream.Start("invExit")
    end

    local actPanel = vgui.Create("DPanel")
    actPanel:SetDrawOnTop(true)
    actPanel:SetSize(100, cInv:GetTall())
    actPanel.Think = function(this)
        if not cInv or not cInv:IsValid() or not cInv:IsVisible() then
            this:Remove()
            return
        end

        local x, y = cInv:GetPos()
        this:SetPos(x - this:GetWide() - 5, y)
    end

    local btnOn = actPanel:Add("DButton")
    btnOn:Dock(TOP)
    btnOn:SetText("Play")
    btnOn:DockMargin(5, 5, 5, 0)
    function btnOn.DoClick()
        netstream.Start("cPlayerActive", entity)
    end

    local btnOff = actPanel:Add("DButton")
    btnOff:Dock(TOP)
    btnOff:SetText("Stop")
    btnOff:DockMargin(5, 5, 5, 0)
    function btnOff.DoClick()
        netstream.Start("cPlayerDisable", entity)
    end

    lia.gui["inv" .. index] = cInv
end)

