lia.command.add("forcenpcspawn", {
    privilege = "Force NPC Spawn",
    superAdminOnly = true,
    syntax = "[string spawnerName]",
    desc = L("forceNPCSpawnDesc"),
    onRun = function(client)
        local map = game.GetMap()
        local zones = MODULE.SpawnPositions[map]
        if not zones then
            client:notify(L("noNPCSpawns"))
            return
        end

        local options = {}
        for spawnerName, _ in pairs(zones) do
            table.insert(options, spawnerName)
        end

        client:requestDropdown(L("selectSpawnerTitle"), L("selectSpawnerPrompt"), options, function(selectedSpawner)
            if not selectedSpawner then return end
            local zone = zones[selectedSpawner]
            if zone then
                local spawned, err = processZone(zone, selectedSpawner)
                if spawned then
                    client:notify(L("forcedSpawnSuccess", selectedSpawner))
                else
                    if err then
                        client:notify(L("forcedSpawnBlocked", selectedSpawner))
                    else
                        client:notify(L("forcedSpawnFailed", selectedSpawner))
                    end
                end
            else
                client:notify(L("spawnerNotFound"))
            end
        end)
    end
})