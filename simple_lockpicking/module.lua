﻿MODULE.name = "Lockpicking"
MODULE.author = "76561198312513285"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.2"
MODULE.Public = true
MODULE.desc = "Adds simple Lockpicking to bruteforce doors!"

if SERVER then
    lia.log.addType("lockpick", function(client, target)
        return string.format("%s lockpicked %s", client:Name(), tostring(target))
    end, "Player")
end
