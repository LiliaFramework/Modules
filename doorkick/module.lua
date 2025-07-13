MODULE.name = "Door Kick"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 10007
MODULE.desc = "Lets players breach doors by kicking them open, with events logged for staff."
MODULE.Public = true
if SERVER then lia.log.addType("doorkick", function(client, door) return string.format("%s kicked open %s", client:Name(), tostring(door)) end, "Player") end
MODULE.Features = {"Adds the ability to kick doors open with an animation", "Adds logging of door kick events", "Adds a fun breach mechanic", "Adds physics force to fling doors open", "Adds a cooldown to prevent spam kicking"}
