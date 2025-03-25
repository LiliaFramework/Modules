lia.command.add("forcenpcspawn", {
    privilege = "Force NPC Spawn",
    superAdminOnly = true,
    syntax = "[string spawnerName]",
    desc = "Force-spawns NPCs at the chosen spawn zone, overriding cooldown if possible.",
    onRun = function(client)
        local map = game.GetMap()
        local zones = MODULE.SpawnPositions[map]
        if not zones then
            client:notify("No NPC Spawns here")
            return
        end

        local options = {}
        for spawnerName, _ in pairs(zones) do
            table.insert(options, spawnerName)
        end

        client:requestDropdown("Select Spawner", "Choose a spawner zone to force a spawn:", options, function(selectedSpawner)
            if not selectedSpawner then return end
            local zone = zones[selectedSpawner]
            if zone then
                local spawned, err = processZone(zone, selectedSpawner)
                if spawned then
                    client:notify("Forced spawn on spawner: " .. selectedSpawner)
                else
                    if err then
                        client:notify("Force spawn did not occur on spawner: " .. selectedSpawner .. " because old NPCs are still alive.")
                    else
                        client:notify("Force spawn did not occur on spawner: " .. selectedSpawner)
                    end
                end
            else
                client:notify("Spawner not found!")
            end
        end)
    end
})
