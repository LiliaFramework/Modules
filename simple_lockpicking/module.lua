MODULE.name = "Lockpicking"
MODULE.author = "76561198312513285"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.3"
MODULE.desc = "Adds simple Lockpicking to bruteforce doors!"
MODULE.Public = true
if SERVER then lia.log.addType("lockpick", function(client, target) return string.format("%s lockpicked %s", client:Name(), tostring(target)) end, "Player") end
MODULE.Features = {"Adds a simple lockpick tool for doors", "Adds logging of successful picks", "Adds brute-force style gameplay",}
