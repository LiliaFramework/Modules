local MODULE = MODULE
local PANEL = {}
local PADDING = 2
local HEADER_HEIGHT = 22
local WEIGHT_PANEL_HEIGHT = 32
local BORDER_FIX_W = 8
local BORDER_FIX_H = 14
local PANEL = {}
function PANEL:Init()
	self:MakePopup()
	self:Center()
	self:SetDraggable(true)
	self:SetTitle(L("inv"))
end

function PANEL:setInventory(inventory)
	self.inventory = inventory
	self:liaListenForInventoryChanges(inventory)
end

function PANEL:InventoryInitialized()
end

function PANEL:InventoryDataChanged()
end

function PANEL:InventoryDeleted(inventory)
	if self.inventory == inventory then self:Remove() end
end

function PANEL:InventoryItemAdded()
end

function PANEL:InventoryItemRemoved()
end

function PANEL:InventoryItemDataChanged()
end

function PANEL:OnRemove()
	self:liaDeleteInventoryHooks()
end

vgui.Register("liaInventory", PANEL, "DFrame")
PANEL2 = {}
function PANEL2:Init()
	self:MakePopup()
	self:InvalidateLayout(true)
	self.content = self:Add("liaListInventoryPanel")
	self.content:Dock(FILL)
end

function PANEL2:setInventory(inventory)
	self.inventory = inventory
	self.content:setInventory(inventory)
	local stacks = MODULE:getItemStacks(inventory)
	local count = 0
	for _ in pairs(stacks) do
		count = count + 1
	end

	if count < 1 then count = 1 end
	local iconSize = 64 + PADDING
	local minCols = 6
	local defaultCols = 12
	local baseWidth = defaultCols * iconSize + BORDER_FIX_W
	local width = baseWidth * 0.5
	local cols = math.floor((width - BORDER_FIX_W) / iconSize)
	if cols < minCols then cols = minCols end
	width = cols * iconSize + BORDER_FIX_W
	local rows = math.ceil(count / cols)
	local frameHeight = rows * iconSize + PADDING + HEADER_HEIGHT + BORDER_FIX_H + WEIGHT_PANEL_HEIGHT
	local maxHeight = ScrH() * 0.8
	if frameHeight > maxHeight then frameHeight = maxHeight end
	self:SetSize(width, frameHeight)
	self.content:setColumns(cols)
	self:Center()
end

function PANEL2:Center()
	local sw, sh = ScrW(), ScrH()
	self:SetPos((sw - self:GetWide()) * 0.5, (sh - self:GetTall()) * 0.5)
end

vgui.Register("liaListInventory", PANEL2, "liaInventory")