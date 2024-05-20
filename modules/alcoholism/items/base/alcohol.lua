ITEM.name = "Alcohol Base"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.abv = 10
ITEM.desc = "This some drank, %d%% ABV."
ITEM.category = "Alcohol"
function ITEM:getDesc()
    return Format(self.desc, self.abv)
end

ITEM.functions.use = {
    name = "Drink",
    tip = "drinkTip",
    icon = "icon16/add.png",
    onRun = function(item)
        local client = item.player
        client:AddBAC(item.abv)
        return true
    end,
}
