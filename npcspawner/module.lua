MODULE.name = "NPC Spawner"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.14
MODULE.desc = "Automatically spawns NPCs at designated points and lets admins force spawns."
MODULE.Public = true
if SERVER then lia.log.addType("npcspawn", function(client, spawner) return string.format("%s forced NPC spawn at %s", client:Name(), tostring(spawner)) end, "Player") end
MODULE.Features = {"Adds automatic NPC spawns at points", "Adds the ability for admins to force spawns", "Adds logging of spawn actions", "Adds configuration for spawn intervals", "Adds spawner entity previews"}
