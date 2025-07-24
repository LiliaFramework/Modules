function MODULE:PlayerDeath(client)
    local character = client:getChar()
    if character:IsWanted() and lia.config.get("RemoveWarrantOnDeath") then character:ToggleWanted() end
end

lia.log.addType("warrantIssue", function(client, target)
    return L("warrantIssueLog", client:Name(), target:Name())
end, "Player")
lia.log.addType("warrantRemove", function(client, target)
    return L("warrantRemoveLog", client:Name(), target:Name())
end, "Player")