﻿MODULE.name = "Perma Remove"
MODULE.author = "Boz [Base Code] & Samael [Rewrite]"
MODULE.discord = "bozdev"
MODULE.version = "1.0.3"
MODULE.desc = "Allows staff to permanently remove map entities"
MODULE.Public = true

if SERVER then
    lia.log.addType("permaremove", function(client, entity)
        return string.format("%s permanently removed %s", client:Name(), tostring(entity))
    end, "Player")
end
