function MODULE:Think()
    local map = game.GetMap()
    local mapSpawns = self.SpawnPositions[map]
    if not mapSpawns or #mapSpawns == 0 then return end
    local spawnCooldown = lia.config.get("SpawnCooldown", 240)
    local spawnRadius = lia.config.get("SpawnRadius", 2000)
    if CurTime() >= (self.nextSpawnTime or 0) then
        self.nextSpawnTime = CurTime() + spawnCooldown
        for _, spawn in ipairs(mapSpawns) do
            local found = false
            for _, entity in ipairs(ents.FindInSphere(spawn.pos, spawnRadius)) do
                if entity:GetClass() == spawn.ent then
                    found = true
                    break
                end
            end

            if not found then
                local ent = ents.Create(spawn.ent)
                if IsValid(ent) then
                    ent:SetPos(spawn.pos)
                    ent:Spawn()
                end
            end
        end
    end
end