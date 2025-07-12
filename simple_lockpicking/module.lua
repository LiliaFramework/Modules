MODULE.name = "Lockpicking"
MODULE.author = "76561198312513285"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.3"
MODULE.desc = "Provides a basic lockpick tool for brute forcing doors with logged attempts."
MODULE.Public = true
if SERVER then lia.log.addType("lockpick", function(client, target) return string.format("%s lockpicked %s", client:Name(), tostring(target)) end, "Player") end
MODULE.Features = {"Adds a simple lockpick tool for doors", "Adds logging of successful picks", "Adds brute-force style gameplay", "Adds configurable pick time", "Adds chance for tools to break",}
