function MODULE:PlayerLoadout(ply)
    ply:setNetVar("isPicking", false)
end

lia.log.addType("lockpick", function(client, target) return string.format("%s lockpicked %s", client:Name(), tostring(target)) end, "Player")