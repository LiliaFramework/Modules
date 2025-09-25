util.AddNetworkString("DoorKickView")
lia.log.addType("doorkick", function(client, door) return L("doorkickLog", client:Name(), tostring(door)) end, "Player")
