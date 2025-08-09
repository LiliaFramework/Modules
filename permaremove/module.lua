MODULE.name = "modulePermaRemoveName"
MODULE.author = "Boz [Base Code] & Samael [Rewrite]"
MODULE.discord = "bozdev"
MODULE.version = 1.18
MODULE.desc = "modulePermaRemoveDesc"
MODULE.Public = true
MODULE.Features = {"Adds ability to permanently delete map entities", "Adds logging for each removed entity", "Adds an admin-only command", "Adds confirmation prompts before removal", "Adds restore list to undo mistakes"}
MODULE.Privileges = {
    {
        Name = "Remove Map Entities",
        MinAccess = "admin",
        Category = "Map Cleanup",
    }
}