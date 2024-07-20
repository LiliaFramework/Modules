function MODULE:InitializedModules()
    RunConsoleCommand("spawnmenu_reload")
end

function MODULE:PopulateItems(pnlContent, tree)
    local client = LocalPlayer()
    if IsValid(client) and client:HasPrivilege("Staff Permissions - Can Spawn Menu Items") then
        local categorised = {}
        for _, v in pairs(lia.item.list) do
            local category = v.category and v.category == "misc" and "Miscellaneous" or v.category and v.category or "Miscellaneous"
            categorised[category] = categorised[category] or {}
            table.insert(categorised[category], v)
        end

        for categoryName, v in SortedPairs(categorised) do
            local node = tree:AddNode(categoryName, "icon16/bricks.png")
            node.DoPopulate = function(pnl)
                if pnl.itemPanel then return end
                pnl.itemPanel = vgui.Create("ContentContainer", pnlContent)
                pnl.itemPanel:SetVisible(false)
                pnl.itemPanel:SetTriggerSpawnlistChange(false)
                for _, item in SortedPairsByMemberValue(v, "name") do
                    spawnmenu.CreateContentIcon("item", pnl.itemPanel, {
                        spawnname = item.uniqueID
                    })
                end
            end

            node.DoClick = function(pnl)
                pnl:DoPopulate()
                pnlContent:SwitchPanel(pnl.itemPanel)
            end
        end

        local FirstNode = tree:Root():GetChildNode(0)
        if IsValid(FirstNode) then FirstNode:InternalDoClick() end
    end
end

spawnmenu.AddContentType("item", function(container, object)
    local icon = vgui.Create("SpawnIcon", p)
    icon:SetWide(64)
    icon:SetTall(64)
    icon:InvalidateLayout(true)
    local item = lia.item.list[object.spawnname]
    icon:SetModel(item.model)
    icon:SetTooltip(item.name)
    icon.DoClick = function()
        if LocalPlayer():HasPrivilege("Staff Permissions - Can Spawn Menu Items") then
            surface.PlaySound("ui/buttonclickrelease.wav")
            netstream.Start("liaItemSpawn", item.uniqueID)
        else
            surface.PlaySound("buttons/button10.wav")
        end
    end

    icon:InvalidateLayout(true)
    if IsValid(container) then container:Add(icon) end
    return icon
end)

spawnmenu.AddCreationTab("Items", function()
    local ctrl = vgui.Create("SpawnmenuContentPanel")
    ctrl:EnableSearch("items", "PopulateItems")
    ctrl:CallPopulateHook("PopulateItems")
    return ctrl
end, "icon16/cog_add.png", 200)