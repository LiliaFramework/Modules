function MODULE:PostPlayerLoadout(client)
    if not client:getChar() then return end
    timer.Simple(0.5, function()
        local currentMap = game.GetMap()
        local mapLocations = self.HospitalLocations[currentMap] or {}
        local respawnLocation = table.Random(mapLocations)
        if respawnLocation and IsValid(client) then
            client:SetPos(respawnLocation.pos)
            client:SetAngles(respawnLocation.ang)
        end
    end)
end