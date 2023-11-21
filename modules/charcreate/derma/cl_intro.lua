------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local MODULE = MODULE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:Intro(panel, callback)
    if panel.comesFromF1 then
        callback()
        return
    end

    panel.blur = 0
    if lia.menuMusic then
        lia.menuMusic:Stop()
        lia.menuMusic = nil
        timer.Remove("liaMusicFader")
    end

    sound.PlayFile(
        "sound/typhon/mafia2_theme.mp3",
        "noplay",
        function(station, errorID, fault)
            if station then
                station:SetVolume(0.5)
                station:Play()
                lia.menuMusic = station
            else
                MsgC(Color(255, 50, 50), errorID .. " ")
                MsgC(color_white, fault .. "\n")
            end
        end
    )

    local dark = panel:Add("DPanel")
    dark:SetSize(panel:GetWide(), panel:GetTall())
    dark:Center()
    function dark:Paint(w, h)
        surface.SetDrawColor(Color(0, 0, 0))
        surface.DrawRect(0, 0, w, h)
    end

    local pos, ang = strPosAngConv(MODULE.camPos.backDrop)
    MODULE.view.pos = pos
    MODULE.view.ang = ang + Angle(-90, 0, 0)
    local text = panel:Add("DLabel")
    text:SetFont("introFont")
    text:SetColor(color_white)
    text:SetText("")
    text:Center()
    text:SetAlpha(0)
    function text:SmoothText(text, callback)
        self:AlphaTo(
            0,
            0.5,
            0,
            function()
                self:SetText(text)
                self:SizeToContents()
                self:Center()
                self:AlphaTo(255, 1.5, 0, callback)
            end
        )
    end

    local logo = Material("themis/logotype.png")
    local lp = panel:Add("DPanel")
    lp:SetSize(500, 273)
    lp:Center()
    lp:SetAlpha(0)
    function lp:Paint(w, h)
        surface.SetDrawColor(color_white)
        draw.NoTexture()
        surface.SetMaterial(logo)
        surface.DrawTexturedRect(0, 0, w, 154)
    end

    local presents = lp:Add("DLabel")
    presents:SetText("Presents")
    presents:SetFont("WB_Enormous")
    presents:SetColor(color_white)
    presents:SetContentAlignment(5)
    presents:SizeToContents()
    presents:Dock(BOTTOM)
    dark:AlphaTo(
        0,
        1,
        2,
        function()
            dark:Remove()
            local time = 18
            text:SmoothText(
                "Germany, Berlin - 1942",
                function()
                    local anim = Derma_Anim("CameraMover", panel, function(pnl, anim, dt) MODULE.view.ang = LerpAngle(dt * 0.008, MODULE.view.ang, ang) end)
                    anim:Start(time)
                    panel.camMover = anim
                    timer.Simple(
                        time / 4,
                        function()
                            if not text then return end
                            text:AlphaTo(
                                0,
                                0.2,
                                0,
                                function()
                                    if not lp then return end
                                    lp:AlphaTo(255, 1)
                                    timer.Simple(
                                        (time - time / 4) / 2,
                                        function()
                                            if not lp or not text then return end
                                            lp:AlphaTo(
                                                0,
                                                1,
                                                0,
                                                function()
                                                    callback()
                                                    text:Remove()
                                                    lp:Remove()
                                                    dark:Remove()
                                                end
                                            )
                                        end
                                    )
                                end
                            )
                        end
                    )
                end
            )
        end
    )
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
