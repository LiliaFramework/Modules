lia.log.addType("advert", function(client, msg)
    local name = IsValid(client) and client:Name() or "Console"
    return L("advertLog", name, msg)
end, "Gameplay")