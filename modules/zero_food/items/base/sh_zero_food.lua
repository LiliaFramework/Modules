-------------------------------------------------------------------------------------------
ITEM.name = "Zero Food base"
ITEM.desc = "Tasty"
ITEM.model = "models/props_junk/garbage_takeoutcarton001a.mdl"
ITEM.width = 1
ITEM.height = 1
-------------------------------------------------------------------------------------------
ITEM.functions.Cook = {
    name = "Use for Cooking",
    onRun = function(item)
        local tr = item.player:GetEyeTrace()
        local name = item.name
        zmc.Item.Spawn(tr.HitPos, name)
    end
}
-------------------------------------------------------------------------------------------