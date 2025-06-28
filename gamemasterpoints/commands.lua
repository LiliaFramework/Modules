lia.command.add("gmtpremove", {
    adminOnly = true,
    privilege = "Manage Gamemaster Teleport Points",
    desc = L("deletePoint"),
    syntax = "[string Name]",
    onRun = function(client, arguments) MODULE:RemovePoint(client, table.concat(arguments, " ")) end
})

lia.command.add("gmtpnewname", {
    adminOnly = true,
    privilege = "Manage Gamemaster Teleport Points",
    desc = L("renamePoint"),
    syntax = "[string Name]",
    onRun = function(_, arguments) netstream.Start("gmTPNewName", table.concat(arguments, " ")) end
})

lia.command.add("gmtpmenu", {
    adminOnly = true,
    privilege = "Manage Gamemaster Teleport Points",
    desc = L("tpPointsTitle"),
    onRun = function(client)
        local tbl = {}
        for _, v in pairs(MODULE.tpPoints) do
            table.insert(tbl, {
                name = v.name,
                sound = v.sound,
                effect = v.effect
            })
        end

        netstream.Start(client, "gmTPMenu", tbl)
    end
})

lia.command.add("gmtpmoveto", {
    adminOnly = true,
    privilege = "Manage Gamemaster Teleport Points",
    desc = L("moveToPoint"),
    AdminStick = {
        Name = L("moveToPoint"),
        Category = L("moderationTools"),
        SubCategory = L("teleport")
    },
    syntax = "[player Target] [string Name]",
    onRun = function(client, arguments)
        local target, name
        if lia.util.findPlayer(client, arguments[1]) then
            target = lia.util.findPlayer(client, arguments[1])
            name = table.concat(arguments, " ", 2)
        else
            target = client
            name = table.concat(arguments, " ")
        end

        MODULE:MoveToPoint(target, name)
    end
})
