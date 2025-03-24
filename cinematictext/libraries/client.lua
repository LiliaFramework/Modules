﻿local PANEL = {}
local ScrW, ScrH = ScrW(), ScrH()
local music
local contents = {
    text = "",
    bigText = "",
    color = color_white,
    duration = 6,
    music = true
}

function PANEL:Init()
    if lia.gui.cinematicSplashText then lia.gui.cinematicSplashText:Remove() end
    lia.gui.cinematicSplashText = self
    self:SetSize(ScrW, ScrH)
    self.barSize = ScrH * 0.13
end

function PANEL:Paint()
end

function PANEL:DrawBlackBars()
    self.topBar = self:Add("DPanel")
    self.topBar:SetSize(ScrW, self.barSize + 10)
    self.topBar:SetPos(0, -self.barSize)
    self.topBar.Paint = function(_, w, h)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, 0, w, h)
    end

    self.bottomBar = self:Add("DPanel")
    self.bottomBar:SetSize(ScrW, self.barSize + 10)
    self.bottomBar:SetPos(0, ScrH)
    self.bottomBar.Paint = function(_, w, h)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, 0, w, h)
    end
end

function PANEL:TriggerBlackBars()
    if not (IsValid(self.topBar) and IsValid(self.bottomBar)) then return end
    self.topBar:MoveTo(0, 0, 2, 0, 0.5)
    self.bottomBar:MoveTo(0, ScrH - self.barSize, 2, 0, 0.5, function() self:TriggerText() end)
end

function PANEL:TriggerText()
    local textPanel = self:Add("DPanel")
    textPanel.Paint = function() end
    local panelWide, panelTall = 300, 300
    textPanel:SetSize(panelWide, panelTall)
    if contents.text and contents.text ~= "" then
        textPanel.text = textPanel:Add("DLabel")
        textPanel.text:SetFont("CinematicSplashFont")
        textPanel.text:SetTextColor(contents.color or color_white)
        textPanel.text:SetText(contents.text)
        textPanel.text:SetAutoStretchVertical(true)
        textPanel.text:Dock(TOP)
        textPanel.text:SetAlpha(0)
        textPanel.text:AlphaTo(255, 2, 0, function() if not contents.bigText then self:TriggerCountdown() end end)
        surface.SetFont("CinematicSplashFont")
        textPanel.text.textWide, textPanel.text.textTall = surface.GetTextSize(contents.text)
        panelWide = panelWide > textPanel.text.textWide and panelWide or textPanel.text.textWide
        panelTall = panelTall + textPanel.text.textTall
        textPanel:SetSize(panelWide, panelTall)
    end

    if contents.bigText and contents.bigText ~= "" then
        textPanel.bigText = textPanel:Add("DLabel")
        textPanel.bigText:SetFont("CinematicSplashFontBig")
        textPanel.bigText:SetTextColor(contents.color or color_white)
        textPanel.bigText:SetText(contents.bigText)
        textPanel.bigText:SetAutoStretchVertical(true)
        textPanel.bigText:Dock(TOP)
        textPanel.bigText:SetAlpha(0)
        textPanel.bigText:AlphaTo(255, 2, 1, function() self:TriggerCountdown() end)
        surface.SetFont("CinematicSplashFontBig")
        textPanel.bigText.textWide, textPanel.bigText.textTall = surface.GetTextSize(contents.bigText)
        panelWide = panelWide > textPanel.bigText.textWide and panelWide or textPanel.bigText.textWide
        panelTall = panelTall + textPanel.bigText.textTall
        textPanel:SetSize(panelWide, panelTall)
    end

    if textPanel.text then textPanel.text:DockMargin((panelWide / 2) - (textPanel.text.textWide / 2), 0, 0, 20) end
    if textPanel.bigText then textPanel.bigText:DockMargin((panelWide / 2) - (textPanel.bigText.textWide / 2), 0, 0, 20) end
    textPanel:InvalidateLayout(true)
    textPanel:SetPos(ScrW - textPanel:GetWide() - ScrW * 0.05, ScrH * 0.68)
    if contents.music then
        music = CreateSound(LocalPlayer(), lia.config.get("CinematicTextMusic", "music/stingers/industrial_suspense2.wav"))
        music:PlayEx(0, 100)
        music:ChangeVolume(1, 2)
    end
end

function PANEL:TriggerCountdown()
    self:AlphaTo(0, 4, contents.duration, function() self:Remove() end)
    timer.Simple(contents.duration, function() if music then music:FadeOut(4) end end)
end

vgui.Register("CinematicSplashText", PANEL, "DPanel")
PANEL = {}
function PANEL:Init()
    if not LocalPlayer():hasPrivilege("Commands - Use Cinematic Menu") then return end
    if IsValid(lia.gui.cinematicSplashTextMenu) then lia.gui.cinematicSplashTextMenu:Remove() end
    lia.gui.cinematicSplashTextMenu = self
    self.contents = {
        text = "",
        bigText = "",
        duration = 3,
        blackBars = true,
        music = true,
        color = color_white
    }

    local textEntryTall = ScrH * 0.045
    self:SetSize(ScrW * 0.6, ScrH * 0.6)
    self:Center()
    self:MakePopup()
    self:SetTitle("Cinematic Splash Text Menu")
    local textLabel = self:Add("DLabel")
    textLabel:SetText("Splash Text")
    textLabel:SetFont("CinematicSplashFontSmall")
    textLabel:SetTextColor(lia.config.get("color", Color(75, 119, 190)))
    textLabel:Dock(TOP)
    textLabel:DockMargin(20, 5, 20, 0)
    textLabel:SizeToContents()
    local textEntry = self:Add("DTextEntry")
    textEntry:SetFont("CinematicSplashFontSmall")
    textEntry:Dock(TOP)
    textEntry:DockMargin(20, 5, 20, 0)
    textEntry:SetUpdateOnType(true)
    textEntry.OnValueChange = function(_, value) self.contents.text = value end
    textEntry:SetTall(textEntryTall)
    local bigTextLabel = self:Add("DLabel")
    bigTextLabel:SetText("Big Splash Text (Appears under normal text)")
    bigTextLabel:SetFont("CinematicSplashFontSmall")
    bigTextLabel:SetTextColor(lia.config.get("color", Color(75, 119, 190)))
    bigTextLabel:Dock(TOP)
    bigTextLabel:DockMargin(20, 5, 20, 0)
    bigTextLabel:SizeToContents()
    local bigTextEntry = self:Add("DTextEntry")
    bigTextEntry:SetFont("CinematicSplashFontSmall")
    bigTextEntry:Dock(TOP)
    bigTextEntry:DockMargin(20, 5, 20, 0)
    bigTextEntry:SetUpdateOnType(true)
    bigTextEntry.OnValueChange = function(_, value) self.contents.bigText = value end
    bigTextEntry:SetTall(textEntryTall)
    local durationLabel = self:Add("DLabel")
    durationLabel:SetText("Splash Text Duration")
    durationLabel:SetFont("CinematicSplashFontSmall")
    durationLabel:SetTextColor(lia.config.get("color", Color(75, 119, 190)))
    durationLabel:Dock(TOP)
    durationLabel:DockMargin(20, 5, 20, 0)
    durationLabel:SizeToContents()
    local durationSlider = self:Add("DNumSlider")
    durationSlider:Dock(TOP)
    durationSlider:SetMin(1)
    durationSlider:SetMax(30)
    durationSlider:SetDecimals(0)
    durationSlider:SetValue(self.contents.duration)
    durationSlider:DockMargin(10, 0, 0, 5)
    durationSlider.OnValueChanged = function(_, val) self.contents.duration = math.Round(val) end
    local blackBarBool = self:Add("DCheckBoxLabel")
    blackBarBool:SetText("Draw Black Bars")
    blackBarBool:SetFont("CinematicSplashFontSmall")
    blackBarBool:SetValue(self.contents.blackBars)
    blackBarBool.OnChange = function(_, value) self.contents.blackBars = value end
    blackBarBool:Dock(TOP)
    blackBarBool:DockMargin(20, 5, 20, 0)
    blackBarBool:SizeToContents()
    local musicBool = self:Add("DCheckBoxLabel")
    musicBool:SetText("Play audio")
    musicBool:SetFont("CinematicSplashFontSmall")
    musicBool:SetValue(self.contents.music)
    musicBool.OnChange = function(_, value) self.contents.music = value end
    musicBool:Dock(TOP)
    musicBool:DockMargin(20, 5, 20, 0)
    musicBool:SizeToContents()
    local Mixer = self:Add("DColorMixer")
    Mixer:Dock(TOP)
    Mixer:SetPalette(true)
    Mixer:SetAlphaBar(true)
    Mixer:SetWangs(true)
    Mixer:SetColor(Color(30, 100, 160))
    Mixer:SetTall(textEntryTall * 3.5)
    Mixer:DockMargin(20, 5, 20, 0)
    local quitButton = self:Add("DButton")
    quitButton:Dock(BOTTOM)
    quitButton:DockMargin(20, 5, 20, 0)
    quitButton:SetText("CANCEL")
    quitButton:SetTextColor(Color(255, 0, 0))
    quitButton:SetFont("CinematicSplashFontSmall")
    quitButton:SetTall(ScrH * 0.05)
    quitButton.DoClick = function() self:Remove() end
    local postButton = self:Add("DButton")
    postButton:Dock(BOTTOM)
    postButton:DockMargin(20, 5, 20, 0)
    postButton:SetText("POST")
    postButton:SetTextColor(color_white)
    postButton:SetFont("CinematicSplashFontSmall")
    postButton:SetTall(ScrH * 0.05)
    postButton.DoClick = function()
        if not (self.contents and (self.contents.text or self.contents.bigText)) then
            lia.util.notify("Something went horribly wrong. Try reloading this panel")
            return
        end

        if self.contents.text == "" and self.contents.bigText == "" then
            lia.util.notify("Text is missing. Enter some text to display")
            return
        end

        net.Start("TriggerCinematic")
        net.WriteString(self.contents.text)
        net.WriteString(self.contents.bigText)
        net.WriteUInt(self.contents.duration, 6)
        net.WriteBool(self.contents.blackBars)
        net.WriteBool(self.contents.music)
        net.WriteColor(self.contents.color)
        net.SendToServer()
        lia.util.notify("Splash Text Sent")
        self:Remove()
    end

    self:SizeToContents()
    Mixer.ValueChanged = function(_, col)
        local newColor = Color(col.r, col.g, col.b)
        self.contents.color = newColor
        bigTextLabel:SetTextColor(newColor)
        durationLabel:SetTextColor(newColor)
        postButton:SetTextColor(newColor)
    end
end

vgui.Register("CinematicSplashTextMenu", PANEL, "DFrame")
function MODULE:LoadFonts()
    local font = lia.config.get("CinematicTextFont", "Arial")
    local fontSizeBig = lia.config.get("CinematicTextSizeBig", 30)
    local fontSizeNormal = lia.config.get("CinematicTextSize", 18)
    surface.CreateFont("CinematicSplashFontBig", {
        font = font,
        size = ScreenScale(fontSizeBig),
        extended = true,
        weight = 1000
    })

    surface.CreateFont("CinematicSplashFont", {
        font = font,
        size = ScreenScale(fontSizeNormal),
        extended = true,
        weight = 800
    })

    surface.CreateFont("CinematicSplashFontSmall", {
        font = font,
        size = ScreenScale(10),
        extended = true,
        weight = 800
    })
end
