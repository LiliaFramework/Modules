﻿lia.command.add("subtractcharslots", {
    privilege = "Subtract CharSlots",
    superAdminOnly = true,
    syntax = "[player Target Player]",
    desc = L("subtractCharSlotsDesc"),
    AdminStick = {
        Name = L("subtractCharSlotsDesc"),
        Category = L("characterManagement"),
        SubCategory = L("charSlots")
    },
    onRun = function(client, arguments)
        local target = lia.util.findPlayer(client, arguments[1])
        if not target or not IsValid(target) then
            client:notifyLocalized("targetNotFound")
            return
        end

        SubtractOverrideCharSlots(target)
    end
})

lia.command.add("addcharslots", {
    privilege = "Add CharSlots",
    superAdminOnly = true,
    syntax = "[player Target Player]",
    desc = L("addCharSlotsDesc"),
    AdminStick = {
        Name = L("addCharSlotsDesc"),
        Category = L("characterManagement"),
        SubCategory = L("charSlots")
    },
    onRun = function(client, arguments)
        local target = lia.util.findPlayer(client, arguments[1])
        if not target or not IsValid(target) then
            client:notifyLocalized("targetNotFound")
            return
        end

        AddOverrideCharSlots(target)
    end
})

lia.command.add("setcharslots", {
    privilege = "Set CharSlots",
    superAdminOnly = true,
    syntax = "[player Target Player] [number Slot Count]",
    desc = L("setCharSlotsDesc"),
    AdminStick = {
        Name = L("setCharSlotsDesc"),
        Category = L("characterManagement"),
        SubCategory = L("charSlots")
    },
    onRun = function(client, arguments)
        local target = lia.util.findPlayer(client, arguments[1])
        local count = tonumber(arguments[2])
        if not target or not IsValid(target) then
            client:notifyLocalized("targetNotFound")
            return
        end

        if not count then
            client:notifyLocalized("invalidSlotCount")
            return
        end

        OverrideCharSlots(target, count)
    end
})
