MODULE.name = "Perma Remove"
MODULE.author = "Boz [Base Code] & Samael [Rewrite]"
MODULE.discord = "bozdev"
MODULE.version = 10006
MODULE.desc = "Lets admins permanently delete map entities and logs each removal for review."
MODULE.Public = true
if SERVER then lia.log.addType("permaremove", function(client, entity) return string.format("%s permanently removed %s", client:Name(), tostring(entity)) end, "Player") end
MODULE.Features = {"Adds ability to permanently delete map entities", "Adds logging for each removed entity", "Adds an admin-only command", "Adds confirmation prompts before removal", "Adds restore list to undo mistakes"}
