﻿lia.command.add("classbroadcast", {
    adminOnly = false,
    alias = "classbc",
    syntax = "[string Message]",
    desc = L("classBroadcastTitle"),
    onRun = function(client, arguments)
        local message = table.concat(arguments, " ", 1)
        if not message then return L("invalidArg") end
        if not client:getChar():hasFlags("D") and not client:hasPrivilege("Can Use Class Broadcast") then
            client:notifyLocalized("classBroadcastNoPermission")
            return false
        end

        local options = {}
        for _, class in pairs(lia.class.list) do
            table.insert(options, class.name .. " (" .. class.uniqueID .. ")")
        end

        hook.Run("ClassBroadcastMenuOpened", client, options)
        client:requestOptions(L("classBroadcastTitle"), L("selectClassesPrompt"), options, #options, function(selectedOptions)
            hook.Run("ClassBroadcastMenuClosed", client, selectedOptions)
            local classList = {}
            local classListSimple = {}
            for _, v in ipairs(selectedOptions) do
                local uniqueID = v:match("%((.-)%)")
                for m, n in pairs(lia.class.list) do
                    if n.uniqueID == uniqueID then
                        classList[m] = n.name
                        table.insert(classListSimple, n.name)
                    end
                end
            end

            if table.Count(classList) == 0 then
                client:notifyLocalized("classBroadcastNoValidClasses")
                return
            end

            hook.Run("PreClassBroadcastSend", client, message, classListSimple)
            for _, ply in player.Iterator() do
                if ply == client or ply:getChar() and classList[ply:getChar():getClass()] and SERVER then
                    local displayName = ply:getChar() and ply:getChar():getDisplayedName(client)
                    ClientAddText(ply, Color(200, 200, 100), L("classBroadcastLabel"), Color(255, 255, 255), ": ", Color(180, 180, 100), displayName, Color(255, 255, 255), ": ", message)
                    ClientAddText(ply, Color(200, 200, 100), L("classBroadcastLabel"), Color(255, 255, 255), ": ", L("classBroadcastSentTo", table.concat(classListSimple, ", ")))
                end
            end

            client:notifyLocalized("classBroadcastSent")
            hook.Run("ClassBroadcastSent", client, message, classListSimple)
            lia.log.add(client, "classbroadcast", message)
            hook.Run("ClassBroadcastLogged", client, message, classListSimple)
        end)
    end,
})

lia.command.add("factionbroadcast", {
    adminOnly = false,
    alias = "factionbc",
    syntax = "[string Message]",
    desc = L("factionBroadcastTitle"),
    onRun = function(client, arguments)
        local message = table.concat(arguments, " ", 1)
        if not message then return L("invalidArg") end
        if not client:getChar():hasFlags("B") and not client:hasPrivilege("Can Use Faction Broadcast") then
            client:notifyLocalized("factionBroadcastNoPermission")
            return false
        end

        local options = {}
        for _, faction in pairs(lia.faction.indices) do
            table.insert(options, faction.name .. " (" .. faction.uniqueID .. ")")
        end

        hook.Run("FactionBroadcastMenuOpened", client, options)
        client:requestOptions(L("factionBroadcastTitle"), L("selectFactionsPrompt"), options, #options, function(selectedOptions)
            hook.Run("FactionBroadcastMenuClosed", client, selectedOptions)
            local factionList = {}
            local factionListSimple = {}
            for _, v in ipairs(selectedOptions) do
                local uniqueID = v:match("%((.-)%)")
                for m, n in pairs(lia.faction.indices) do
                    if n.uniqueID == uniqueID then
                        factionList[m] = n.name
                        table.insert(factionListSimple, n.name)
                    end
                end
            end

            if table.Count(factionList) == 0 then
                client:notifyLocalized("factionBroadcastNoValidFactions")
                return
            end

            hook.Run("PreFactionBroadcastSend", client, message, factionListSimple)
            for _, ply in player.Iterator() do
                if ply == client or ply:getChar() and factionList[ply:getChar():getFaction()] and SERVER then
                    local displayName = ply:getChar() and ply:getChar():getDisplayedName(client)
                    ClientAddText(ply, Color(200, 200, 100), L("factionBroadcastLabel"), Color(255, 255, 255), ": ", Color(180, 180, 100), displayName, Color(255, 255, 255), ": ", message)
                    ClientAddText(ply, Color(200, 200, 100), L("factionBroadcastLabel"), Color(255, 255, 255), ": ", L("factionBroadcastSentTo", table.concat(factionListSimple, ", ")))
                end
            end

            client:notifyLocalized("factionBroadcastSent")
            hook.Run("FactionBroadcastSent", client, message, factionListSimple)
            lia.log.add(client, "factionbroadcast", message)
            hook.Run("FactionBroadcastLogged", client, message, factionListSimple)
        end)
    end,
})
