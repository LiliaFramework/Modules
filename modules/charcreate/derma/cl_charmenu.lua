--------------------------------------------------------------------------------------------------------
local MODULE = MODULE
--------------------------------------------------------------------------------------------------------
MODULE.menuMusic = nil
--------------------------------------------------------------------------------------------------------
local PANEL = {}
--------------------------------------------------------------------------------------------------------
function PANEL:Init()
    hook.Add(
        "CalcView",
        "MainMenuView",
        function(ply, pos, angles, fov)
            if not MODULE.view.pos or not MODULE.view.ang then return end
            local view = {}
            view.origin = MODULE.view.pos
            view.angles = MODULE.view.ang
            view.fov = fov
            view.drawviewer = true
            return view
        end
    )

    self.comesFromF1 = false
    if IsValid(lia.gui.loading) then lia.gui.loading:Remove() end
    if IsValid(lia.gui.menu) or (LocalPlayer().getChar and LocalPlayer():getChar()) then
        lia.gui.menu:Remove()
        self.comesFromF1 = true
    end

    lia.gui.char = self
    local backDropPos, backDropAng = strPosAngConv(MODULE.camPos.backDrop)
    MODULE.view.pos = backDropPos
    MODULE.view.ang = backDropAng
    local title = group()
    self.buttonColor = Color(35, 35, 35, 80)
    self.blur = 2
    self.anims = {}
    self.light = false
    self:SetSize(ScrW(), ScrH())
    self:MakePopup()
    self:Center()
    self:ParentToHUD()
    self:SetAlpha(0)
    self:AlphaTo(255, 0.2)
    self:SetZPos(800)
    function self.drawMenuButton(pnl)
        pnl.defaultColor = self.buttonColor
        pnl.color = pnl.defaultColor
        AccessorFunc(pnl, "color", "Color")
        function pnl:OnCursorEntered()
            self:ColorTo(Color(255, 255, 255), 0.15)
            self:SetTextColor(color_black)
            MODULE:PlaySound()
        end

        function pnl:OnCursorExited()
            self:ColorTo(self.defaultColor, 0.15)
            self:SetTextColor(color_white)
        end

        function pnl:PlayClickSound()
            MODULE:PlaySound(true)
        end
    end

    --Close button
    self.close = self:Add("WButton")
    self.close:SetSize(60, 30)
    self.close:SetText("X")
    self.close:SetColor(color_white)
    self.close:SetPos(self:GetWide() - self.close:GetWide(), 0)
    self.close:SetAccentColor(Color(245, 75, 75))
    function self.close.Think(this)
        if self.wp and IsValid(self.wp) then this:SetZPos(self.wp:GetZPos() + 1) end
    end

    function self.close.DoClick()
        self:Remove()
    end

    if not self.comesFromF1 then
        self.close:SetVisible(false)
        self.close:SetDisabled(true)
    end

    --Blur functions
    function self:BlurIncreaser()
        if self.anims["blur+"] then self.anims["blur+"] = nil end
        local anim = Derma_Anim(
            "BlurIncreaser",
            self,
            function(pnl, anim, dt)
                local nBlur = Lerp(dt, 0, 4)
                pnl.blur = nBlur
            end
        )

        anim:Start(2)
        self.blurIncrease = anim
    end

    function self:BlurDecreaser()
        if self.anims["blur-"] then self.anims["blur-"] = nil end
        local anim = Derma_Anim(
            "BlurIncreaser",
            self,
            function(pnl, anim, dt)
                local nBlur = Lerp(dt, 4, 0)
                pnl.blur = nBlur
            end
        )

        anim:Start(2)
        self.blurDecrease = anim
    end

    --Overall think method
    function self:Think()
        if self.blurIncrease and self.blurIncrease:Active() then self.blurIncrease:Run() end
        if self.blurDecrease and self.blurDecrease:Active() then self.blurDecrease:Run() end
        if self.camMover and self.camMover:Active() then self.camMover:Run() end
        --Light to see the face of the character
        if self.light and self.cmdl and IsValid(self.cmdl) then
            local dlight = DynamicLight(LocalPlayer():EntIndex())
            if dlight then
                dlight.pos = self.cmdl:GetPos() + Vector(0, 40, 100)
                dlight.r = 255
                dlight.g = 255
                dlight.b = 255
                dlight.brightness = 2
                dlight.Decay = 1000
                dlight.Size = 256
                dlight.DieTime = CurTime() + 1
            end
        end

        --Camera ocsilation
        if (self.camMover and not self.camMover:Active()) or not self.camMover then
            local ang = MODULE.view.ang
            local amount = 1
            if not ang then return end
            local osci = math.sin(CurTime() / 2 * amount * math.pi) * FrameTime() / 2
            local nAng = Angle(ang.pitch + osci, ang.yaw + osci, ang.roll + osci / 2)
            MODULE.view.ang = nAng
        end
    end

    MODULE:Intro(
        self,
        function()
            --Back button
            self.back = self:Add("WButton")
            self.back:SetFont("WB_Small")
            self.back:SetText("<- Back")
            self.back:SetSize(120, 30)
            self.back:SetPos(10, 10)
            self.back:SetTextColor(color_white)
            self.drawMenuButton(self.back)
            self.back:SetAlpha(0)
            self.back:Hide()
            function self.back.DoBack(this, group)
                function this.DoClick(this)
                    MODULE:PlaySound(true)
                    --Removing the panels in the group
                    group:FadeOutRem(
                        function()
                            title:FadeIn()
                            if self.cmdl then self.cmdl:Remove() end
                        end,
                        true
                    )

                    --Fading out
                    this:SetDisabled(true)
                    this:AlphaTo(
                        0,
                        0.5,
                        0,
                        function()
                            this:Hide()
                            this:SetDisabled(false)
                        end
                    )

                    --Rewind back calcview
                    if MODULE.view.pos ~= backDropPos or MODULE.view.ang ~= backDropAng then
                        local anim = Derma_Anim(
                            "CameraMoverBack",
                            panel,
                            function(pnl, anim, dt)
                                MODULE.view.pos = LerpVector(dt ^ 2, MODULE.view.pos, backDropPos)
                                MODULE.view.ang = LerpAngle(dt ^ 2, MODULE.view.ang, backDropAng)
                            end
                        )

                        anim:Start(2)
                        self.camMover = anim
                    end

                    if self.blur == 0 then
                        print("Increase blur")
                        self:BlurIncreaser()
                    end
                end
            end

            --Title screen logo
            local asp = 1152 / 296
            local w = 512
            title.logoPnl = self:Add("DPanel")
            title.logoPnl:SetSize(w, w / asp)
            title.logoPnl:CenterHorizontal()
            title.logoPnl:CenterVertical(0.25)
            function title.logoPnl:Paint(w, h)
                surface.SetDrawColor(255, 255, 255, 0)
                --surface.SetMaterial(MODULE.mafiaTitle)
                surface.DrawTexturedRect(0, 0, w, h)
            end

            --Creating scroll & list
            title.buttonScroll = self:Add("DScrollPanel")
            title.buttonScroll:SetSize(400, 60)
            title.buttonScroll:Center()
            local bList = title.buttonScroll:Add("DIconLayout")
            bList:SetSize(title.buttonScroll:GetSize())
            bList:SetSpaceY(5)
            function self:menuButton(text, parent)
                parent = parent or bList
                local b = parent:Add("DButton")
                b:SetFont("WB_Large")
                b:SetSize(400, 40)
                b:SetText(text)
                b:SetTextColor(color_white)
                self.drawMenuButton(b)
                function b:Paint(w, h)
                    lia.util.drawBlur(self, 6)
                    draw.RoundedBox(0, 0, 0, w, h, self.color)
                end
                return b
            end

            local function changeScreen(callback)
                --Hiding title screen logo and buttons
                for k, v in pairs(title:GetChildren()) do
                    v:AlphaTo(0, 0.5, 0, function() v:Hide() end)
                end

                timer.Simple(
                    0.5,
                    function()
                        local group = group()
                        callback(MODULE, self, group)
                        self.back:Show()
                        self.back:AlphaTo(255, 0.5)
                        self.back:DoBack(group)
                    end
                )
            end

            --Creating main buttons
            if #lia.characters > 0 then
                title.play = self:menuButton("PLAY", bList)
            else
                title.createNew = self:menuButton("CREATE NEW CHARACTER", bList)
            end

            title.manage = self:menuButton("MANAGE CHARACTERS", bList)
            if #lia.characters <= 0 then
                title.manage:SetDisabled(true)
                title.manage:SetColor(Color(50, 50, 50, 150))
                title.manage:SetTextColor(Color(100, 100, 100))
                --Diable the hover thing
                title.manage.OnCursorEntered = nil
                title.manage.OnCursorExited = nil
            end

            title.quit = self:menuButton("QUIT", bList)
            if title.play then
                function title.play.DoClick(this)
                    this:PlayClickSound()
                    changeScreen(MODULE.Play)
                    self:BlurDecreaser()
                end
            end

            if title.createNew then
                function title.createNew.DoClick(this)
                    this:PlayClickSound()
                    changeScreen(MODULE.Create)
                end
            end

            function title.manage.DoClick(this)
                this:PlayClickSound()
                changeScreen(MODULE.Manage)
            end

            function title.quit.DoClick(this)
                this:PlayClickSound()
                Choice_Request("Are you sure you want to quit?", function() RunConsoleCommand("disconnect") end, nil)
            end

            --Justifying button list heihgt
            title.buttonScroll:SetTall((40 + bList:GetSpaceY()) * #bList:GetChildren())
            bList:SetTall(title.buttonScroll:GetTall())
            --Fancy fading
            title.buttonScroll:SetAlpha(0)
            title.logoPnl:SetAlpha(0)
            local delay = self.comesFromF1 and 0 or 1
            title.logoPnl:AlphaTo(255, 0.8, delay, function() title.buttonScroll:AlphaTo(255, 0.5, 0) end)
            self:BlurIncreaser()
        end
    )
end

function PANEL:Paint(w, h)
    lia.util.drawBlur(self, self.blur)
    surface.SetDrawColor(0, 0, 0, 80)
    surface.DrawRect(0, 0, w, h)
end

function PANEL:OnKeyCodePressed(key)
    if key == KEY_F1 and not self.comesFromF1 then self:Remove() end
    if key == KEY_F2 then
        netstream.Start("charChoose", 1)
        self:Remove()
    end
end

function PANEL:OnRemove()
    ANIM:Stop()
    hook.Remove("CalcView", "MainMenuView") --Removing custom view
    --Remove clientside model
    if self.cmdl then self.cmdl:Remove() end
    if lia.menuMusic then
        local fraction = 1
        local start, finish = RealTime(), RealTime() + 10
        timer.Create(
            "liaMusicFader",
            0.1,
            0,
            function()
                if lia.menuMusic then
                    fraction = 1 - math.TimeFraction(start, finish, RealTime())
                    lia.menuMusic:SetVolume(fraction * 0.5)
                    if fraction <= 0 then
                        lia.menuMusic:Stop()
                        lia.menuMusic = nil
                        timer.Remove("liaMusicFader")
                    end
                else
                    timer.Remove("liaMusicFader")
                end
            end
        )
    end
end

--------------------------------------------------------------------------------------------------------
vgui.Register("liaCharacter", PANEL, "EditablePanel")
--------------------------------------------------------------------------------------------------------
function MODULE:CreateMenuButtons(tabs)
    tabs["characters"] = function(panel)
        if IsValid(lia.gui.menu) then lia.gui.menu:Remove() end
        vgui.Create("liaCharacter")
    end
end
--------------------------------------------------------------------------------------------------------
--[[
hook.Add("CreateMenuButtons", "liaCharButton", function(tabs)
	tabs["characters"] = function(panel)
		vgui.Create("liaCharacter")
	end
end)
]]
--------------------------------------------------------------------------------------------------------
