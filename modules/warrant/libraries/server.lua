function MODULE:PlayerDeath(client)
    if client:IsWanted() and self.RemoveWarrantOnDeath then
        client:ToggleWanted()
    end
end