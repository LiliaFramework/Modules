MODULE.name = "Tying"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.9"
MODULE.desc = "Adds Tying Items That Serve As Handcuffs. Enchance Roleplay Overall."
MODULE.Public = true

if SERVER then
    lia.log.addType("tie", function(client, target)
        return string.format("%s tied %s", client:Name(), IsValid(target) and target:Name() or "unknown")
    end, "Player")

    lia.log.addType("untie", function(client, target)
        return string.format("%s untied %s", client:Name(), IsValid(target) and target:Name() or "unknown")
    end, "Player")
end
MODULE.Features = {}
