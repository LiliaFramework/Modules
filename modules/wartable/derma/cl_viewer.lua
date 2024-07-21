local PANEL = {}

function PANEL:Init()
    local pWidth, pHeight = ScrW() * 0.75, ScrH() * 0.75
    self:SetSize(pWidth, pHeight)
    self:Center()
    self:SetBackgroundBlur(true)
    self:SetDeleteOnClose(true)
    self:MakePopup()
    self:SetTitle("Customize Marker")
    self.bodygroups = self:Add("DScrollPanel")
    self.bodygroups:Dock(RIGHT)
end

function PANEL:Display(target, pos)
    local pWidth, pHeight = ScrW() * 0.75, ScrH() * 0.75
    self.saveButton = self:Add("DButton")
    self.saveButton:Dock(BOTTOM)
    self.saveButton:DockMargin(0, 4, 0, 0)
    self.saveButton:SetText("Submit")
    self.saveButton.DoClick = function()
        local bodygroups = {}
        for _, v in pairs(self.bodygroupIndex) do
            table.insert(bodygroups, v.index, v.value)
        end

        netstream.Start("PlaceWarTableMarker", pos, bodygroups)
        self:Remove()
    end

    self.model = self:Add("DModelPanel")
    self.model:SetSize(pWidth * 1 / 2, pHeight)
    self.model:Dock(LEFT)
    self.model:SetModel(target:GetModel())
    self.model:SetFOV(5)
    self.model:SetLookAng(Angle(10, 225, 0))
    self.model:SetCamPos(Vector(40, 40, 11))
    self.target = target
    self:PopulateBodygroupOptions()
end

function PANEL:PopulateBodygroupOptions()
    self.bodygroupBox = {}
    self.bodygroupName = {}
    self.bodygroupPrevious = {}
    self.bodygroupNext = {}
    self.bodygroupIndex = {}
    self.bodygroups:Dock(FILL)
    for _, v in pairs(self.target:GetBodyGroups()) do
        if not (v.id == 0) then
            local index = v.id
            self.bodygroupBox[v.id] = self.bodygroups:Add("DPanel")
            self.bodygroupBox[v.id]:Dock(TOP)
            self.bodygroupBox[v.id]:DockMargin(20, 20, 20, 0)
            self.bodygroupBox[v.id]:SetHeight(50)
            self.bodygroupName[v.id] = self.bodygroupBox[v.id]:Add("DLabel")
            self.bodygroupName[v.id].index = v.id
            self.bodygroupName[v.id]:SetText(v.name:gsub("^%l", string.upper))
            self.bodygroupName[v.id]:SetFont("liaMediumFont")
            self.bodygroupName[v.id]:Dock(LEFT)
            self.bodygroupName[v.id]:DockMargin(30, 0, 0, 0)
            self.bodygroupName[v.id]:SetWidth(200)
            self.bodygroupNext[v.id] = self.bodygroupBox[v.id]:Add("DButton")
            self.bodygroupNext[v.id].index = v.id
            self.bodygroupNext[v.id]:Dock(RIGHT)
            self.bodygroupNext[v.id]:SetText("Next")
            self.bodygroupNext[v.id].DoClick = function()
                local index = v.id
                if (self.model.Entity:GetBodygroupCount(index) - 1) <= self.bodygroupIndex[index].value then return end
                self.bodygroupIndex[index].value = self.bodygroupIndex[index].value + 1
                self.bodygroupIndex[index]:SetText(self.bodygroupIndex[index].value)
                self.model.Entity:SetBodygroup(index, self.bodygroupIndex[index].value)
            end

            self.bodygroupIndex[v.id] = self.bodygroupBox[v.id]:Add("DLabel")
            self.bodygroupIndex[v.id].index = v.id
            self.bodygroupIndex[v.id].value = self.target:GetBodygroup(index)
            self.bodygroupIndex[v.id]:SetText(self.bodygroupIndex[v.id].value)
            self.bodygroupIndex[v.id]:SetFont("liaMediumFont")
            self.bodygroupIndex[v.id]:Dock(RIGHT)
            self.bodygroupIndex[v.id]:SetContentAlignment(5)
            self.bodygroupPrevious[v.id] = self.bodygroupBox[v.id]:Add("DButton")
            self.bodygroupPrevious[v.id].index = v.id
            self.bodygroupPrevious[v.id]:Dock(RIGHT)
            self.bodygroupPrevious[v.id]:SetText("Previous")
            self.bodygroupPrevious[v.id].DoClick = function()
                local index = v.id
                if 0 == self.bodygroupIndex[index].value then return end
                self.bodygroupIndex[index].value = self.bodygroupIndex[index].value - 1
                self.bodygroupIndex[index]:SetText(self.bodygroupIndex[index].value)
                self.model.Entity:SetBodygroup(index, self.bodygroupIndex[index].value)
            end

            self.model.Entity:SetBodygroup(index, self.target:GetBodygroup(index))
        end
    end
end

vgui.Register("WarTableModelViewer", PANEL, "DFrame")
