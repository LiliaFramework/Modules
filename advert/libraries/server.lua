lia.log.addType("advert", function(client, msg)
    return string.format("%s advertised: %s", IsValid(client) and client:Name() or "Console", msg)
end, "Gameplay")
