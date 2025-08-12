ITEM.name = "Flashlight"
ITEM.desc = "A standard flashlight that can be toggled."
ITEM.model = "models/Items/battery.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.isFlashlight = true
ITEM:hook("drop", function(item) item.player:Flashlight(false) end)