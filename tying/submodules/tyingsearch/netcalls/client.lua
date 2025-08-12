local MODULE = MODULE
MODULE.searchPanels = MODULE.searchPanels or {}
net.Receive("searchPly", function()
    local target = net.ReadEntity()
    local id = net.ReadUInt(32)
    local targetInv = lia.inventory.instances[id]
    if not targetInv then
        net.Start("searchExit")
        net.SendToServer()
        return
    end

    local myInvPanel, targetInvPanel
    local exitLock = true
    local function onRemove(panel)
        local other = panel == myInvPanel and targetInvPanel or myInvPanel
        if IsValid(other) and exitLock then
            exitLock = false
            other:Remove()
        end

        net.Start("searchExit")
        net.SendToServer()
        panel:searchOnRemove()
    end

    myInvPanel = LocalPlayer():getChar():getInv():show()
    myInvPanel:ShowCloseButton(true)
    myInvPanel.searchOnRemove = myInvPanel.OnRemove
    myInvPanel.OnRemove = onRemove
    targetInvPanel = targetInv:show()
    targetInvPanel:ShowCloseButton(true)
    targetInvPanel:SetTitle(target:Name())
    targetInvPanel.searchOnRemove = targetInvPanel.OnRemove
    targetInvPanel.OnRemove = onRemove
    myInvPanel.x = myInvPanel.x + myInvPanel:GetWide() * 0.5 + 2
    targetInvPanel:MoveLeftOf(myInvPanel, 4)
    MODULE.searchPanels[#MODULE.searchPanels + 1] = myInvPanel
    MODULE.searchPanels[#MODULE.searchPanels + 1] = targetInvPanel
end)

net.Receive("searchExit", function()
    for _, panel in pairs(MODULE.searchPanels) do
        if IsValid(panel) then panel:Remove() end
    end

    MODULE.searchPanels = {}
end)