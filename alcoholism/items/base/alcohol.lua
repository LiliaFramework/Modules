ITEM.name = "Alcohol Base"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.abv = 0
ITEM.category = "Alcohol"
function ITEM:getDesc()
    return L("alcoholDesc", self.abv)
end

ITEM.functions.use = {
    name = L("drinkAction"),
    tip = L("drinkTip"),
    icon = "icon16/add.png",
    onRun = function(item)
        local client = item.player
        client:AddBAC(item.abv)
        client:EmitSound("vo/npc/male01/drink01.wav", 75, 100)
        return true
    end,
}