function MODULE:PlayerDeath(client)
    local character = client:getChar()
    if character:IsWanted() and lia.config.get("RemoveWarrantOnDeath") then character:ToggleWanted() end
end