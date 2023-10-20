--------------------------------------------------------------------------------------------------------
AddCSLuaFile()
--------------------------------------------------------------------------------------------------------
ENT.Base = "craftingbase"
--------------------------------------------------------------------------------------------------------
ENT.PrintName = "Workbench"
ENT.Purpose = "Use this workbench to craft things."
ENT.Model = "models/hourofvictory/work_bench1.mdl"
ENT.InvWidth = 7
ENT.InvHeight = 12
ENT.CraftSound = "player/shove_01.wav"
ENT.WeaponAttachments = true
ENT.AllowedBlueprints = {
	b_diamondring = true,
	b_processedgold = false, 
	b_processediron = false, 
	b_processedsilver = false, 
}
--------------------------------------------------------------------------------------------------------
CraftingTables = CraftingTables or {}
CraftingTables[ENT.PrintName] = ENT.AllowedBlueprints
--------------------------------------------------------------------------------------------------------