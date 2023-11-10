--------------------------------------------------------------------------------------------------------
ITEM.name = "Zero's Crafting Components"
ITEM.model = "models/props_junk/garbage_takeoutcarton001a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "Base for Zero's Crafting Components."
ITEM.category = "Crafting Components"
--------------------------------------------------------------------------------------------------------
ITEM.functions.CraftP = {
    name = "Use for Crafting",
    onRun = function(item)
        local tr = item.player:GetEyeTrace()
        for k, v in pairs(zpf.config.Items) do
            zpf.Item.Spawn(item.numeral, 1, tr.HitPos, item.player)
        end
    end
}
--------------------------------------------------------------------------------------------------------
