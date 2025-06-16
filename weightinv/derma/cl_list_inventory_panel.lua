local MODULE = MODULE
local PANEL = {}
local PADDING = 2
local WEIGHT_PANEL_HEIGHT = 32
function PANEL:Init()
	self:SetPaintBackground(false)
	self.weight = self:Add("DPanel")
	self.weight:SetTall(WEIGHT_PANEL_HEIGHT + PADDING)
	self.weight:Dock(TOP)
	self.weight:DockMargin(0, 0, 0, PADDING)
	self.weight:InvalidateLayout(true)
	self.weightBar = self.weight:Add("DPanel")
	self.weightBar:Dock(FILL)
	self.weightBar:DockMargin(PADDING, PADDING, PADDING, PADDING)
	self.weightBar.Paint = function(this, w, h) self:paintWeightBar(w, h) end
	self.weightLabel = self.weight:Add("DLabel")
	self.weightLabel:SetFont("liaChatFont")
	self.weightLabel:Dock(FILL)
	self.weightLabel:SetContentAlignment(5)
	self.weightLabel:SetExpensiveShadow(1, Color(0, 0, 0, 100))
	self.scroll = self:Add("DScrollPanel")
	self.scroll:Dock(FILL)
	self.scroll.VBar:SetWide(8)
	self.scroll.VBar:SetHideButtons(true)
	function self.scroll.VBar:Paint(w, h)
		surface.SetDrawColor(50, 50, 50, 200)
		surface.DrawRect(0, 0, w, h)
	end

	function self.scroll.VBar.btnGrip:Paint(w, h)
		surface.SetDrawColor(100, 100, 100, 200)
		surface.DrawRect(0, 0, w, h)
	end

	self.content = self.scroll:Add("DGrid")
	self.content:Dock(FILL)
	self.content:SetCols(1)
	self.content:SetColWide(64 + PADDING)
	self.content:SetRowHeight(64 + PADDING)
	self.icons = {}
end

function PANEL:setInventory(inventory)
	self.inventory = inventory
	self:liaListenForInventoryChanges(inventory)
	self:populateItems()
	self:updateWeight()
end

function PANEL:setColumns(numColumns, iconSideLength)
	iconSideLength = iconSideLength or 64 + PADDING
	self.content:SetCols(numColumns)
	self.content:SetColWide(iconSideLength)
	self.content:SetRowHeight(iconSideLength)
	self.scroll:InvalidateLayout(true)
end

function PANEL:populateItems()
	for _, icon in pairs(self.icons) do
		self.content:RemoveItem(icon)
	end

	local stacks = MODULE:getItemStacks(self.inventory)
	for key, stack in SortedPairs(stacks) do
		if not IsValid(self.icons[key]) and #stack > 0 then
			local icon = self.content:Add("liaItemIcon")
			icon:setItemType(stack[1]:getID())
			icon.PaintBehind = self.itemPaintBehind
			icon.OnMousePressed = function(itemIcon, keyCode) self:onItemPressed(itemIcon, keyCode) end
			local quantity = icon:Add("DLabel")
			quantity:SetPos(PADDING, PADDING)
			quantity:SetFont("liaChatFont")
			quantity:SetText(#stack)
			quantity:SetExpensiveShadow(1, Color(0, 0, 0, 100))
			quantity:SizeToContents()
			self.icons[key] = icon
			self.content:AddItem(icon)
		end
	end

	self.content:InvalidateLayout(true)
	self.scroll:InvalidateLayout(true)
end

function PANEL:updateWeight()
	if not self.inventory then return end
	self.weightLabel:SetText(L"WeightInv":upper() .. ": " .. self.inventory:getWeight() .. "/" .. self.inventory:getMaxWeight() .. lia.config.get("invWeightUnit", "KG"))
end

function PANEL:paintWeightBar(w, h)
	if not self.inventory then return end
	local weight = self.inventory:getWeight()
	local maxWeight = self.inventory:getMaxWeight()
	local percentage = math.Clamp(weight / maxWeight, 0, 1)
	surface.SetDrawColor(lia.config.get("Color"))
	surface.DrawRect(0, 0, w * percentage, h)
end

function PANEL:itemPaintBehind(w, h)
	surface.SetDrawColor(0, 0, 0, 50)
	surface.DrawRect(0, 0, w, h)
	surface.SetDrawColor(0, 0, 0, 150)
	surface.DrawOutlinedRect(0, 0, w, h)
end

function PANEL:onItemPressed(itemIcon, keyCode)
	itemIcon:openActionMenu()
end

function PANEL:InventoryItemAdded()
	self:populateItems()
	self:updateWeight()
end

function PANEL:InventoryItemRemoved()
	self:populateItems()
	self:updateWeight()
end

function PANEL:InventoryItemDataChanged()
	self:populateItems()
	self:updateWeight()
end

function PANEL:InventoryDataChanged(key)
	if key == "maxWeight" then self:updateWeight() end
end

function PANEL:InventoryDeleted(inventory)
	if self.inventory == inventory then self:Remove() end
end

function PANEL:OnRemove()
	self:liaDeleteInventoryHooks()
end

vgui.Register("liaListInventoryPanel", PANEL, "DPanel")