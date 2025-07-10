local MODULE = MODULE
local PANEL = {}
local PADDING, HEADER_HEIGHT, WEIGHT_PANEL_HEIGHT, BORDER_FIX_W, BORDER_FIX_H, FOOTER_HEIGHT = 2, 22, 32, 8, 14, 32
function PANEL:Init()
    self:MakePopup()
    self:SetDraggable(true)
    self.storagePane = self:Add("DPanel")
    self.storagePane:Dock(LEFT)
    self.storageLabel = self.storagePane:Add("DLabel")
    self.storageLabel:Dock(TOP)
    self.storageLabel:SetTall(HEADER_HEIGHT)
    self.storageLabel:SetFont("liaChatFont")
    self.storageLabel:SetContentAlignment(5)
    self.storageInv = self.storagePane:Add("liaListInventoryPanel")
    self.storageInv:Dock(FILL)
    self.invPane = self:Add("DPanel")
    self.invPane:Dock(FILL)
    self.invLabel = self.invPane:Add("DLabel")
    self.invLabel:Dock(TOP)
    self.invLabel:SetTall(HEADER_HEIGHT)
    self.invLabel:SetFont("liaChatFont")
    self.invLabel:SetContentAlignment(5)
    self.localInv = self.invPane:Add("liaListInventoryPanel")
    self.localInv:Dock(FILL)
    self.storageInv.onItemPressed = function(_, id) self:onItemPressed(id) end
    self.localInv.onItemPressed = function(_, id) self:onItemPressed(id) end
end

function PANEL:setStorage(storage)
    if self.storage and IsValid(self.storage) then self.storage:RemoveCallOnRemove("ListStorageView") end
    local char = LocalPlayer():getChar()
    if not (IsValid(storage) and char and storage:getInv() and char:getInv()) then
        if IsValid(self) then self:Remove() end
        return
    end

    self.storage = storage
    storage:CallOnRemove("ListStorageView", function() if IsValid(self) then self:Remove() end end)
    local invLocal = char:getInv()
    local invStorage = storage:getInv()
    local stacksLocal = lia.module.list["weightinv"]:getItemStacks(invLocal)
    local stacksStore = lia.module.list["weightinv"]:getItemStacks(invStorage)
    local countLocal = table.Count(stacksLocal)
    local countStore = table.Count(stacksStore)
    if countLocal < 1 then countLocal = 1 end
    if countStore < 1 then countStore = 1 end
    local iconSize = 64 + PADDING
    local minCols = 6
    local defaultCols = 12
    local baseWidth = defaultCols * iconSize + BORDER_FIX_W
    local cols = math.floor((baseWidth * 0.5 - BORDER_FIX_W) / iconSize)
    if cols < minCols then cols = minCols end
    local halfW = cols * iconSize + BORDER_FIX_W
    local maxCount = math.max(countLocal, countStore)
    local rows = math.ceil(maxCount / cols)
    local frameH = rows * iconSize + PADDING + HEADER_HEIGHT + BORDER_FIX_H + WEIGHT_PANEL_HEIGHT + FOOTER_HEIGHT
    if frameH > ScrH() then frameH = ScrH() end
    local totalW = halfW * 2 + PADDING
    self:SetSize(totalW, frameH)
    self.storagePane:SetWide(halfW)
    self.invPane:SetWide(halfW)
    local name = L(storage:getStorageInfo().name or "Storage")
    self:SetTitle(name)
    self.storageLabel:SetText(name)
    self.invLabel:SetText(L("inv"))
    self.storageInv:setColumns(cols)
    self.storageInv:setInventory(invStorage)
    self.localInv:setColumns(cols)
    self.localInv:setInventory(invLocal)
    self:Center()
end

function PANEL:Center()
    local sw, sh = ScrW(), ScrH()
    self:SetPos((sw - self:GetWide()) * 0.5, (sh - self:GetTall()) * 0.5)
end

function PANEL:OnRemove()
    if self.storage and IsValid(self.storage) then self.storage:RemoveCallOnRemove("ListStorageView") end
    MODULE:exitStorage()
end

function PANEL:onItemPressed(itemID)
    MODULE:transferItem(itemID)
end

vgui.Register("liaListStorage", PANEL, "DFrame")
