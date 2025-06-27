lia.command.add("forcenpcspawn", {
    privilege = "Force NPC Spawn",
    superAdminOnly = true,
    syntax = "[string Spawner Name]",
    desc = L("forceNPCSpawnDesc"),
    onRun = function(client)
        local map = game.GetMap()
        local zones = MODULE.SpawnPositions[map]
        if not zones then
            client:notifyLocalized("noNPCSpawns")
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
                    client:notifyLocalized("forcedSpawnSuccess", selectedSpawner)
                else
                    if err then
                        client:notifyLocalized("forcedSpawnBlocked", selectedSpawner)
                    else
                        client:notifyLocalized("forcedSpawnFailed", selectedSpawner)
                    end
                end
            else
                client:notifyLocalized("spawnerNotFound")
            end
        end)
    end
})
