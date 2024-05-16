-- Create a custom font
surface.CreateFont("liaDialFont", {
    font = "Arial",
    size = 20,
    weight = 500,
    antialias = true,
    shadow = false
})

-- Define a modern color scheme
local modernColors = {
    background = Color(45, 45, 45, 255), -- Dark gray
    buttonNormal = Color(60, 60, 60, 255), -- Lighter gray
    buttonHover = Color(80, 80, 80, 255), -- Even lighter gray for hover effect
    text = Color(255, 255, 255, 255) -- White for text
}

-- Create a PANEL for the radio dial
local PANEL = {}
function PANEL:Init()
    self.number = 0 -- Initialize the number to 0
    self:SetWide(70)
    -- Function to style buttons
    local function styleButton(btn)
        btn:SetFont("Marlett")
        btn:SetTextColor(modernColors.text)
        btn.Paint = function(self, w, h)
            local color = self:IsHovered() and modernColors.buttonHover or modernColors.buttonNormal
            draw.RoundedBox(4, 0, 0, w, h, color) -- Rounded corners
        end
    end

    -- Create and style the 'up' button
    local up = self:Add("DButton")
    up:SetText("t") -- Use the character that corresponds to the desired arrow symbol
    up:Dock(TOP)
    up:DockMargin(2, 2, 2, 2)
    up.DoClick = function(this)
        self.number = (self.number + 1) % 10
        surface.PlaySound("buttons/lightswitch2.wav")
        self:InvalidateLayout(true)
    end

    styleButton(up)
    -- Create and style the 'down' button
    local down = self:Add("DButton")
    down:SetText("u") -- Use the character that corresponds to the desired arrow symbol
    down:Dock(BOTTOM)
    down:DockMargin(2, 2, 2, 2)
    down.DoClick = function(this)
        self.number = (self.number - 1) % 10
        surface.PlaySound("buttons/lightswitch2.wav")
        self:InvalidateLayout(true)
    end

    styleButton(down)
    -- Style the number display
    self.numberDisplay = self:Add("DLabel")
    self.numberDisplay:Dock(FILL)
    self.numberDisplay:SetFont("liaDialFont")
    self.numberDisplay:SetTextColor(modernColors.text)
    self.numberDisplay:SetContentAlignment(5)
    self:InvalidateLayout(true)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(4, 0, 0, w, h, modernColors.background)
    self.numberDisplay:SetText(tostring(self.number)) -- Update the display text
end

vgui.Register("liaRadioDial", PANEL, "DPanel")
-- Reset PANEL for the next UI element
PANEL = {}
function PANEL:Init()
    self:SetTitle("Radio Frequency")
    self:SetSize(350, 180) -- Adjust the overall size of the menu
    self:Center()
    self:MakePopup()
    -- Container for dials to control the layout more effectively
    local dialsContainer = self:Add("DPanel")
    dialsContainer:Dock(TOP)
    dialsContainer:SetTall(100) -- Adjust the height to fit the dials
    dialsContainer:DockMargin(10, 10, 10, 0) -- Add some margin for aesthetics
    dialsContainer:DockPadding(5, 0, 5, 0) -- Padding to space out the dials from the container edges
    dialsContainer.Paint = nil -- No need to paint this, set to nil to avoid unnecessary drawing
    self.dial = {}
    for i = 1, 5 do
        if i ~= 4 then
            -- For the numbers
            self.dial[i] = dialsContainer:Add("liaRadioDial")
            self.dial[i]:Dock(LEFT)
            self.dial[i]:DockMargin(0, 0, i ~= 3 and 5 or 15, 0) -- Adjust spacing between dials
        else
            -- For the dot
            local dot = dialsContainer:Add("DLabel")
            dot:SetWide(10) -- Make the dot label narrower
            dot:Dock(LEFT)
            dot:SetText(".")
            dot:SetFont("liaDialFont")
            dot:SetTextColor(modernColors.text)
            dot:SetContentAlignment(5)
        end
    end

    -- Submit button
    self.submit = self:Add("DButton")
    self.submit:Dock(BOTTOM)
    self.submit:SetTall(24) -- Height of the submit button
    self.submit:DockMargin(10, 4, 10, 4) -- Margin around the submit button
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
