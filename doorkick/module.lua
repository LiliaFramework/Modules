MODULE.name = "Door Kick"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.5"
MODULE.desc = "Allows you to kick doors open."
MODULE.Public = true

if SERVER then
    lia.log.addType("doorkick", function(client, door)
        return string.format("%s kicked open %s", client:Name(), tostring(door))
    end, "Player")
end
