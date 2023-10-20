--------------------------------------------------------------------------------------------------------
AddCSLuaFile()
--------------------------------------------------------------------------------------------------------
ENT.Base = "craftingbase"
--------------------------------------------------------------------------------------------------------
ENT.PrintName = "Smelting Furnace"
ENT.Purpose = "Use this to smelt ore into bars."
ENT.Model = "models/props_wasteland/laundry_washer003.mdl"
ENT.InvWidth = 9
ENT.InvHeight = 8
ENT.CraftSound = "player/shove_01.wav"
ENT.WeaponAttachments = true
ENT.AllowedBlueprints = {
	b_diamondring = false,
	b_processedgold = true, 
	b_processediron = true, 
	b_processedsilver = true, 
}
--------------------------------------------------------------------------------------------------------
CraftingTables = CraftingTables or {}
CraftingTables[ENT.PrintName] = ENT.AllowedBlueprints
--------------------------------------------------------------------------------------------------------