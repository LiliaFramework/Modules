lia.command.add("forcenpcspawn", {
    superAdminOnly = true,
    arguments = {
        {
            name = "spawnerName",
            type = "string"
        }
    },
    desc = "forceNPCSpawnDesc",
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
                    lia.log.add(client, "npcspawn", selectedSpawner)
                    hook.Run("OnNPCForceSpawn", client, selectedSpawner)
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