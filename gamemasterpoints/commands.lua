local MODULE = MODULE
lia.command.add("gmtpremove", {
    adminOnly = true,
    desc = "deletePoint",
    arguments = {
        {
            name = "name",
            type = "string"
        }
    },
    onRun = function(client, arguments) MODULE:RemovePoint(client, table.concat(arguments, " ")) end
})

lia.command.add("gmtpnewname", {
    adminOnly = true,
    desc = "renamePoint",
    arguments = {
        {
            name = "name",
            type = "string"
        }
    },
    onRun = function(_, arguments)
        net.Start("gmTPNewName")
        net.WriteString(table.concat(arguments, " "))
        net.Broadcast()
    end
})

lia.command.add("gmtpmenu", {
    adminOnly = true,
    desc = "tpPointsTitle",
    onRun = function(client)
        local tbl = {}
        for _, v in pairs(MODULE.tpPoints) do
            table.insert(tbl, {
                name = v.name,
                sound = v.sound,
                effect = v.effect
            })
        end

        net.Start("gmTPMenu")
        net.WriteTable(tbl)
        net.Send(client)
    end
})

lia.command.add("gmtpmoveto", {
    adminOnly = true,
    desc = "moveToPoint",
    AdminStick = {
        Name = "moveToPoint",
        Category = "moderationTools",
        SubCategory = "teleport"
    },
    arguments = {
        {
            name = "target",
            type = "player",
            optional = true
        },
        {
            name = "name",
            type = "string"
        }
    },
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