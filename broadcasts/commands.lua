lia.command.add("classbroadcast", {
    adminOnly = false,
    alias = "classbc",
    arguments = {
        {
            name = "message",
            type = "string"
        }
    },
    desc = "classBroadcastTitle",
    onRun = function(client, arguments)
        local message = table.concat(arguments, " ", 1)
        if not message then return "invalidArg" end
        if not client:getChar():hasFlags("D") and not client:hasPrivilege("canUseClassBroadcast") then
            client:notify("You aren't allowed to send a class broadcast.")
            return false
        end

        local options = {}
        for _, class in pairs(lia.class.list) do
            table.insert(options, class.name .. " (" .. class.uniqueID .. ")")
        end

        client:requestOptions("Send a broadcast to selected classes.", "Choose classes to send to:", options, #options, function(selectedOptions)
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
                client:notify("No valid classes were chosen.")
                return
            end

            for _, ply in player.Iterator() do
                if ply == client or ply:getChar() and classList[ply:getChar():getClass()] and SERVER then
                    local displayName = ply:getChar() and ply:getChar():getDisplayedName(client)
                    lia.util.addText(ply, Color(200, 200, 100), "[CLASS BROADCAST]", Color(255, 255, 255), ": ", Color(180, 180, 100), displayName, Color(255, 255, 255), ": ", message)
                    lia.util.addText(ply, Color(200, 200, 100), "[CLASS BROADCAST]", Color(255, 255, 255), ": ", string.format("Sent to: %s", table.concat(classListSimple, ", ")))
                end
            end

            client:notify("Class broadcast sent.")
        end)
    end,
})

lia.command.add("factionbroadcast", {
    adminOnly = false,
    alias = "factionbc",
    arguments = {
        {
            name = "message",
            type = "string"
        }
    },
    desc = "factionBroadcastTitle",
    onRun = function(client, arguments)
        local message = table.concat(arguments, " ", 1)
        if not message then return "invalidArg" end
        if not client:getChar():hasFlags("B") and not client:hasPrivilege("canUseFactionBroadcast") then
            client:notify("You aren't allowed to send a faction broadcast.")
            return false
        end

        local options = {}
        for _, faction in pairs(lia.faction.indices) do
            table.insert(options, faction.name .. " (" .. faction.uniqueID .. ")")
        end

        client:requestOptions("Send a broadcast to selected factions.", "Choose factions to send to:", options, #options, function(selectedOptions)
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
                client:notify("No valid factions were chosen.")
                return
            end

            for _, ply in player.Iterator() do
                if ply == client or ply:getChar() and factionList[ply:getChar():getFaction()] and SERVER then
                    local displayName = ply:getChar() and ply:getChar():getDisplayedName(client)
                    lia.util.addText(ply, Color(200, 200, 100), "[FACTION BROADCAST]", Color(255, 255, 255), ": ", Color(180, 180, 100), displayName, Color(255, 255, 255), ": ", message)
                    lia.util.addText(ply, Color(200, 200, 100), "[FACTION BROADCAST]", Color(255, 255, 255), ": ", string.format("Sent to: %s", table.concat(factionListSimple, ", ")))
                end
            end

            client:notify("Faction broadcast sent.")
        end)
    end,
})
