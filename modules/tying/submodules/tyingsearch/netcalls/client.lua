----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local MODULE = MODULE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
MODULE.searchPanels = MODULE.searchPanels or {}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
net.Receive(
    "RequestID",
    function(len, client)
        lia.util.notifQuery(
            "A player is requesting to see your ID.",
            "Accept",
            "Deny",
            true,
            NOT_CORRECT,
            function(code)
                if code == 1 then
                    net.Start("ApproveID")
                    net.WriteBool(true)
                    net.SendToServer()
                elseif code == 2 then
                    net.Start("ApproveID")
                    net.WriteBool(false)
                    net.SendToServer()
                end
            end
        )
    end
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
netstream.Hook(
    "searchPly",
    function(target, id)
        local targetInv = lia.inventory.instances[id]
        if not targetInv then return netstream.Start("searchExit") end
        local myInvPanel, targetInvPanel
        local exitLock = true
        local function onRemove(panel)
            local other = panel == myInvPanel and targetInvPanel or myInvPanel
            if IsValid(other) and exitLock then
                exitLock = false
                other:Remove()
            end

            netstream.Start("searchExit")
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
        myInvPanel.x = myInvPanel.x + (myInvPanel:GetWide() * 0.5) + 2
        targetInvPanel:MoveLeftOf(myInvPanel, 4)
        MODULE.searchPanels[#MODULE.searchPanels + 1] = myInvPanel
        MODULE.searchPanels[#MODULE.searchPanels + 1] = targetInvPanel
    end
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
netstream.Hook(
    "searchExit",
    function()
        for _, panel in pairs(MODULE.searchPanels) do
            if IsValid(panel) then panel:Remove() end
        end

        MODULE.searchPanels = {}
    end
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
net.Receive(
    "RequestSearch",
    function(len, client)
        lia.util.notifQuery(
            "A player is requesting to search your inventory.",
            "Accept",
            "Deny",
            true,
            NOT_CORRECT,
            function(code)
                if code == 1 then
                    net.Start("ApproveSearch")
                    net.WriteBool(true)
                    net.SendToServer()
                elseif code == 2 then
                    net.Start("ApproveSearch")
                    net.WriteBool(false)
                    net.SendToServer()
                end
            end
        )
    end
)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------