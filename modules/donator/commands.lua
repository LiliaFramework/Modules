lia.command.add("subtractcharslots", {
    privilege = "Characters - Subtract CharSlots",
    superAdminOnly = true,
    syntax = "<string player>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if not target or not IsValid(target) then
            client:notifyLocalized("noTarget")
            return
        end

        SubtractOverrideCharSlots(target)
    end
})

lia.command.add("addcharslots", {
    privilege = "Characters - Add CharSlots",
    superAdminOnly = true,
    syntax = "<string player>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if not target or not IsValid(target) then
            client:notifyLocalized("noTarget")
            return
        end

        AddOverrideCharSlots(target)
    end
})

lia.command.add("setcharslots", {
    privilege = "Characters - Set CharSlots",
    superAdminOnly = true,
    syntax = "<string player> <number count>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        local count = tonumber(arguments[2])
        if not target or not IsValid(target) then
            client:notifyLocalized("noTarget")
            return
        end

        if not count then client:notify("You didn't specify a count!") end
        OverrideCharSlots(target, count)
    end
})