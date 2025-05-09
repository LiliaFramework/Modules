﻿lia.command.add("viewBodygroups", {
    adminOnly = true,
    privilege = "Manage Bodygroups",
    syntax = "[string targetPlayer]",
    desc = L("viewBodygroupsDesc"),
    onRun = function(client, arguments)
        local target = lia.util.findPlayer(client, arguments[1] or "")
        if not target or not IsValid(target) then
            client:notifyLocalized("targetNotFound")
            return
        end

        net.Start("BodygrouperMenu")
        net.WriteEntity(target)
        net.Send(client)
    end
})
