ITEM.name = "Alcohol Base"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.abv = 10
ITEM.category = "Alcohol"
function ITEM:getDesc()
    return string.format("A alcoholic beverage with %d%% ABV.", self.abv)
end

ITEM.functions.use = {
    name = "Drink",
    tip = "drinkTip",
    icon = "icon16/add.png",
    onRun = function(item)
        local client = item.player
        client:AddBAC(item.abv)
        client:EmitSound("vo/npc/male01/drink01.wav", 75, 100)
        return true
    end,
}
