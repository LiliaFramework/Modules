﻿MODULE.name = "Perma Remove"
MODULE.uniqueID = "public_permaremove"
MODULE.author = "Boz [Base Code] & Samael [Rewrite]"
MODULE.discord = "bozdev"
MODULE.version = 1.25
MODULE.desc = "Adds ability to permanently delete map entities, logging for each removed entity, an admin-only command, confirmation prompts before removal, and restore list to undo mistakes."
MODULE.Features = {"Adds ability to permanently delete map entities", "Adds logging for each removed entity", "Adds an admin-only command", "Adds confirmation prompts before removal", "Adds restore list to undo mistakes"}
MODULE.Privileges = {
    {
        Name = "removeMapEntities",
        ID = "removeMapEntities",
        MinAccess = "admin",
        Category = "mapCleanup",
    }
}