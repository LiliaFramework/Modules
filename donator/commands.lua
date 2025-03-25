lia.command.add("subtractcharslots", {
    privilege = "Subtract CharSlots",
    superAdminOnly = true,
    syntax = "[string targetPlayer]",
    desc = "Removes one character slot from the specified player.",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
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
    syntax = "[string targetPlayer]",
    desc = "Grants one extra character slot to the specified player.",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
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
    syntax = "[string targetPlayer] [number slotCount]",
    desc = "Sets the total number of character slots for the specified player.",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        local count = tonumber(arguments[2])
        if not target or not IsValid(target) then
            client:notifyLocalized("targetNotFound")
            return
        end

        if not count then
            client:notify("You didn't specify a valid slot count!")
            return
        end

        OverrideCharSlots(target, count)
    end
})
