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
        local map = lia.data.getEquivalencyMap(game.GetMap())
        local zones = MODULE.SpawnPositions[map]
        if not zones then
            client:notify("No NPC spawns are defined on this map.")
            return
        end

        local options = {}
        for spawnerName, _ in pairs(zones) do
            table.insert(options, spawnerName)
        end

        client:requestDropdown("Choose Spawner", "Select a spawner:", options, function(selectedSpawner)
            if not selectedSpawner then return end
            local zone = zones[selectedSpawner]
            if zone then
                local spawned, err = processZone(zone, selectedSpawner)
                if spawned then
                    client:notify(string.format("NPCs spawned at %s.", selectedSpawner))
                else
                    if err then
                        client:notify("NPCs are already alive for that spawner.")
                    else
                        client:notify("Failed to force spawn NPCs.")
                    end
                end
            else
                client:notify("Spawner not found.")
            end
        end)
    end
})
