lia.command.add("subtractcharslots", {
    superAdminOnly = true,
    arguments = {
        {
            name = "target",
            type = "player"
        }
    },
    desc = "subtractCharSlotsDesc",
    AdminStick = {
        Name = "subtractCharSlotsDesc",
        Category = "characterManagement",
        SubCategory = "charSlots"
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
    superAdminOnly = true,
    arguments = {
        {
            name = "target",
            type = "player"
        }
    },
    desc = "addCharSlotsDesc",
    AdminStick = {
        Name = "addCharSlotsDesc",
        Category = "characterManagement",
        SubCategory = "charSlots"
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
    superAdminOnly = true,
    arguments = {
        {
            name = "target",
            type = "player"
        },
        {
            name = "count",
            type = "number"
        }
    },
    desc = "setCharSlotsDesc",
    AdminStick = {
        Name = "setCharSlotsDesc",
        Category = "characterManagement",
        SubCategory = "charSlots"
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
