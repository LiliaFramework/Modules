lia.command.add("classbroadcast", {
    adminOnly = false,
    syntax = "<string classes> <string text>",
    onRun = function(client, arguments)
        if not arguments[1] then return "Invalid argument (#1)" end
        if not arguments[2] then return "Invalid argument (#2)" end
        local message = table.concat(arguments, " ", 2)
        local classList = {}
        local classListSimple = {}
        if not client:getChar():hasFlags("B") then
            client:notify("Your rank is not high enough to use this command.")
            return false
        end

        for _, v in pairs(string.Explode(",", arguments[1])) do
            local foundClass
            local foundID
            local multiFind
            for m, n in pairs(lia.class.list) do
                if string.lower(n.uniqueID) == string.lower(v) then
                    foundClass = m
                    foundID = n.name
                    multiFind = false
                    client:ChatPrint(n.name)
                    break
                elseif string.lower(n.uniqueID):find(string.lower(v), 1, true) then
                    if foundClass then multiFind = true end
                    foundID = n.name
                    client:ChatPrint(n.name)
                    foundClass = m
                end
            end

            if not foundClass then return "Cannot find class '" .. v .. "' - use the unique IDs of classes" end
            if multiFind then return "Ambiguous entry (multiple possible classes) - '" .. v .. "'" end
            classList[foundClass] = foundID
            classListSimple[#classListSimple + 1] = foundID
        end

        if table.Count(classList) == 0 then return "No valid classes found" end
        for _, v in pairs(player.GetAll()) do
            if v == client or (v:getChar() and classList[v:getChar():getClass()]) then
                net.Start("classbroadcast_client")
                net.WriteString(client:Nick())
                net.WriteString(message)
                net.WriteTable(classListSimple)
                net.Send(v)
            end
        end

        client:notify("Broadcast sent.")
    end
})

lia.command.add("factionbroadcast", {
    adminOnly = false,
    syntax = "<string factions> <string text>",
    onRun = function(client, arguments)
        if not arguments[1] then return "Invalid argument (#1)" end
        if not arguments[2] then return "Invalid argument (#2)" end
        local message = table.concat(arguments, " ", 2)
        local factionList = {}
        local factionListSimple = {}
        if not client:getChar():hasFlags("B") then
            client:notify("Your rank is not high enough to use this command.")
            return false
        end

        for _, v in pairs(string.Explode(",", arguments[1])) do
            local foundFaction
            local foundID
            local multiFind
            for m, n in pairs(lia.faction.indices) do
                if string.lower(n.uniqueID) == string.lower(v) then
                    foundFaction = m
                    foundID = n.name
                    multiFind = false
                    client:ChatPrint(n.name)
                    break
                elseif string.lower(n.uniqueID):find(string.lower(v), 1, true) then
                    if foundFaction then multiFind = true end
                    foundID = n.name
                    client:ChatPrint(n.name)
                    foundFaction = m
                end
            end

            if not foundFaction then return "Cannot find faction '" .. v .. "' - use the unique IDs of factions (example: OKW, OKH, CITIZEN, etc)" end
            if multiFind then return "Ambiguous entry (multiple possible factions) - '" .. v .. "'" end
            factionList[foundFaction] = foundID
            factionListSimple[#factionListSimple + 1] = foundID
        end

        if table.Count(factionList) == 0 then return "No valid factions found" end
        for _, v in pairs(player.GetAll()) do
            if v == client or (v:getChar() and factionList[v:getChar():getFaction()]) then
                net.Start("factionbroadcast_client")
                net.WriteString(client:Nick())
                net.WriteString(message)
                net.WriteTable(factionListSimple)
                net.Send(v)
            end
        end

        client:notify("Broadcast sent.")
    end
})