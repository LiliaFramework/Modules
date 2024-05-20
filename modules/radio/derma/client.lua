local modernColors = {
    background = Color(45, 45, 45, 255), -- Dark gray
    buttonNormal = Color(60, 60, 60, 255), -- Lighter gray
    buttonHover = Color(80, 80, 80, 255), -- Even lighter gray for hover effect
    text = Color(255, 255, 255, 255) -- White for text
}

local PANEL = {}
function PANEL:Init()
    self.number = 0
    self:SetWide(70)
    local function styleButton(btn)
        btn:SetFont("Marlett")
        btn:SetTextColor(modernColors.text)
        btn.Paint = function(self, w, h)
            local color = self:IsHovered() and modernColors.buttonHover or modernColors.buttonNormal
            draw.RoundedBox(4, 0, 0, w, h, color)
        end
    end

    local up = self:Add("DButton")
    up:SetText("t")
    up:Dock(TOP)
    up:DockMargin(2, 2, 2, 2)
    up.DoClick = function()
        self.number = (self.number + 1) % 10
        surface.PlaySound("buttons/lightswitch2.wav")
        self:InvalidateLayout(true)
    end

    styleButton(up)
    local down = self:Add("DButton")
    down:SetText("u")
    down:Dock(BOTTOM)
    down:DockMargin(2, 2, 2, 2)
    down.DoClick = function()
        self.number = (self.number - 1) % 10
        surface.PlaySound("buttons/lightswitch2.wav")
        self:InvalidateLayout(true)
    end

    styleButton(down)
    self.numberDisplay = self:Add("DLabel")
    self.numberDisplay:Dock(FILL)
    self.numberDisplay:SetFont("liaDialFont")
    self.numberDisplay:SetTextColor(modernColors.text)
    self.numberDisplay:SetContentAlignment(5)
    self:InvalidateLayout(true)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(4, 0, 0, w, h, modernColors.background)
    self.numberDisplay:SetText(tostring(self.number))
end

vgui.Register("liaRadioDial", PANEL, "DPanel")
PANEL = {}
function PANEL:Init()
    self:SetTitle("Radio Frequency")
    self:SetSize(350, 180)
    self:Center()
    self:MakePopup()
    local dialsContainer = self:Add("DPanel")
    dialsContainer:Dock(TOP)
    dialsContainer:SetTall(100)
    dialsContainer:DockMargin(10, 10, 10, 0)
    dialsContainer:DockPadding(5, 0, 5, 0)
    dialsContainer.Paint = nil
    self.dial = {}
    for i = 1, 5 do
        if i ~= 4 then
            self.dial[i] = dialsContainer:Add("liaRadioDial")
            self.dial[i]:Dock(LEFT)
            self.dial[i]:DockMargin(0, 0, i ~= 3 and 5 or 15, 0)
        else
            local dot = dialsContainer:Add("DLabel")
            dot:SetWide(10)
            dot:Dock(LEFT)
            dot:SetText(".")
            dot:SetFont("liaDialFont")
            dot:SetTextColor(modernColors.text)
            dot:SetContentAlignment(5)
        end
    end

    self.submit = self:Add("DButton")
    self.submit:Dock(BOTTOM)
    self.submit:SetTall(24)
    self.submit:DockMargin(10, 4, 10, 4)
    self.submit:SetText("Submit")
    self.submit.DoClick = function()
        local str = ""
        for i = 1, 5 do
            if i ~= 4 then
                str = str .. tostring(self.dial[i].number or 0)
            else
                str = str .. "."
            end
        end

        netstream.Start("radioAdjust", str, self.itemID)
        self:Close()
    end
end

vgui.Register("liaRadioMenu", PANEL, "DFrame")
