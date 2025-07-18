MODULE.name = "Tying"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.23
MODULE.desc = "Introduces handcuff-style tying items for arrests and logs all tie or untie actions."
MODULE.Public = true
if SERVER then
    lia.log.addType("tie", function(client, target) return string.format("%s tied %s", client:Name(), IsValid(target) and target:Name() or "unknown") end, "Player")
    lia.log.addType("untie", function(client, target) return string.format("%s untied %s", client:Name(), IsValid(target) and target:Name() or "unknown") end, "Player")
end

MODULE.Features = {"Adds handcuff items that restrain players", "Adds logging for tie and untie events", "Adds support for roleplay arrests", "Adds timed escape minigames for prisoners", "Adds compatibility with the search submodule"}
