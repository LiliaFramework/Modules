function MODULE:Think()
    if CurTime() >= (self.nextSpawnTime or 0) then
        self.nextSpawnTime = CurTime() + self.SpawnCooldown
        for _, spawn in ipairs(self.SpawnPositions) do
            local found = false
            for _, entity in ipairs(ents.FindInSphere(spawn.pos, self.SpawnRadius)) do
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