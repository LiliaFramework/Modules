function MODULE:PlayerDeath(victim)
    if victim:IsWanted() and self.RemoveWarrantOnDeaththen then victim:ToggleWanted() end
end
