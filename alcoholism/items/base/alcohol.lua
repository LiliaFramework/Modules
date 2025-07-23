ITEM.name = "Alcohol Base"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.abv = 0
ITEM.category = "Alcohol"
ITEM.desc = L("alcoholDesc", ITEM.abv or 0)
ITEM.functions.use = {
    name = L("drinkAction"),
    tip = L("drinkTip"),
    icon = "icon16/add.png",
    onRun = function(item)
        local client = item.player
        client:AddBAC(item.abv)
        hook.Run("AlcoholConsumed", client, item)
        client:EmitSound("vo/npc/male01/drink01.wav", 75, 100)
        return true
    end,
}