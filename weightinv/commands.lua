lia.command.add("updateinvsize", {
    adminOnly = true,
    privilege = "Set Inventory Weight",
    desc = L("updateInventoryWeightDesc"),
    AdminStick = {
        Name = L("updateInventoryWeightDesc"),
        Category = L("characterManagement"),
        SubCategory = L("inventory")
    },
    syntax = "[player Target Player]",
    onRun = function(client, args)
        local target = lia.util.findPlayer(client, args[1])
        if not target or not IsValid(target) then
            client:notifyLocalized("targetNotFound")
            return
        end

        local char = target:getChar()
        if not char then
            client:notifyLocalized("noCharacterLoaded")
            return
        end

        local inv = char:getInv()
        if not inv then
            client:notifyLocalized("noInventory")
            return
        end

        local defaultMax = hook.Run("GetDefaultInventoryMaxWeight", target) or lia.config.get("invMaxWeight")
        local currentMax = tonumber(inv:getData("maxWeight", defaultMax))
        if currentMax == defaultMax then
            client:notifyLocalized("inventoryAlreadyWeight", target:Name(), defaultMax)
            return
        end

        inv:setData("maxWeight", defaultMax)
        inv:sync(target)
        client:notifyLocalized("updatedInventoryWeight", target:Name(), defaultMax)
    end
})

lia.command.add("setinventorysize", {
    adminOnly = true,
    privilege = "Set Inventory Weight",
    desc = L("setInventoryWeightDesc"),
    AdminStick = {
        Name = L("setInventoryWeightDesc"),
        Category = L("characterManagement"),
        SubCategory = L("inventory")
    },
    syntax = "[player Target Player] [number Max Weight]",
    onRun = function(client, args)
        local target = lia.util.findPlayer(client, args[1])
        if not target or not IsValid(target) then
            client:notifyLocalized("targetNotFound")
            return
        end

        local weight = tonumber(args[2])
        if not weight then
            client:notifyLocalized("invalidWeight")
            return
        end

        local char = target:getChar()
        if not char then
            client:notifyLocalized("noCharacterLoaded")
            return
        end

        local inv = char:getInv()
        if not inv then
            client:notifyLocalized("noInventory")
            return
        end

        inv:setData("maxWeight", weight)
        inv:sync(target)
        client:notifyLocalized("setInventoryWeightNotify", target:Name(), weight)
    end
})
