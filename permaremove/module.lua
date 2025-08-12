MODULE.name = "Perma Remove"
MODULE.author = "Boz [Base Code] & Samael [Rewrite]"
MODULE.discord = "bozdev"
MODULE.version = 1.22
MODULE.desc = "Adds ability to permanently delete map entities, logging for each removed entity, an admin-only command, confirmation prompts before removal, and restore list to undo mistakes."
MODULE.Public = true
MODULE.Features = {"Adds ability to permanently delete map entities", "Adds logging for each removed entity", "Adds an admin-only command", "Adds confirmation prompts before removal", "Adds restore list to undo mistakes"}
MODULE.Privileges = {
    {
        Name = "removeMapEntities",
        ID = "removeMapEntities",
        MinAccess = "admin",
        Category = "Map Cleanup",
    }
}