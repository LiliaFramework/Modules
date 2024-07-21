local MODULE = MODULE
CraftingTables = CraftingTables or {}
ENT.Type = "anim"
ENT.Author = "Samael"
ENT.Contact = "@liliaplayer"
ENT.Instructions = "Press USE whilst looking at table to open crafting menu."
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.Category = "Crafting"
ENT.IsCraftingTable = true
ENT.IsPersistent = MODULE.PermanentCraftingTables
function ENT:getInv()
    return lia.inventory.instances[self:getNetVar("id", 0)]
end