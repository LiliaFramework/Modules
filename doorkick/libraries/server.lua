util.AddNetworkString("DoorKickView")
lia.log.addType("doorkick", function(client, door) return string.format("%s kicked open %s", client:Name(), tostring(door)) end, "Player")