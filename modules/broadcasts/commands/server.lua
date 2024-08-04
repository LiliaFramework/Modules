lia.command.add("classbroadcast", {
    adminOnly = false,
    syntax = "<string text>",
    onRun = function(client, arguments)
        if not arguments[1] then return "Invalid argument (#1)" end
        local message = table.concat(arguments, " ", 1)
        
        if not client:getChar():hasFlags("B") then
            client:notify("Your rank is not high enough to use this command.")
            return false
        end

        local options = {}
        for _, class in pairs(lia.class.list) do
            table.insert(options, class.name .. " (" .. class.uniqueID .. ")")
        end
        
        client:requestOptions("Class Broadcast", "Select classes to broadcast to:", options, #options, function(selectedOptions)
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
                client:notify("No valid classes selected")
                return
            end

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
        end)
    end
})

lia.command.add("factionbroadcast", {
    adminOnly = false,
    syntax = "<string text>",
    onRun = function(client, arguments)
        if not arguments[1] then return "Invalid argument (#1)" end
        local message = table.concat(arguments, " ", 1)

        if not client:getChar():hasFlags("B") then
            client:notify("Your rank is not high enough to use this command.")
            return false
        end

        local options = {}
        for _, faction in pairs(lia.faction.indices) do
            table.insert(options, faction.name .. " (" .. faction.uniqueID .. ")")
        end

        client:requestOptions("Faction Broadcast", "Select factions to broadcast to:", options, #options, function(selectedOptions)
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
                client:notify("No valid factions selected")
                return
            end

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
        end)
    end
})