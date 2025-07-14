local MODULE = MODULE
function MODULE:runCutscene(id)
    local cs = self.cutscenes[id]
    if not cs then return end
    hook.Run("CutsceneStarted", id)
    local pl = LocalPlayer()
    local w, h = ScrW(), ScrH()
    local fade = vgui.Create("DPanel")
    fade:SetSize(w, h)
    fade:SetSkin("Default")
    fade:SetBackgroundColor(color_black)
    fade:SetAlpha(0)
    fade:SetZPos(999)
    local panel = vgui.Create("DPanel")
    panel:SetSize(w, h)
    panel:SetZPos(999)
    local html = panel:Add("DHTML")
    html:SetSize(w, h * 0.75)
    local cutStarted
    panel.Paint = function()
        if cutStarted then
            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawRect(-1, -1, w + 2, h + 2)
        end

        local scene = pl.scene
        if scene and scene.subtitle then
            surface.SetFont(scene.font)
            local col = scene.color or Color(64, 100, 100)
            surface.SetTextColor(col.r, col.g, col.b, 255)
            local lines = lia.util.wrapText(scene.subtitle, w * 0.5, scene.font)
            local offset = 0
            for _, line in pairs(lines) do
                local tw, th = surface.GetTextSize(line)
                surface.SetTextPos(w * 0.5 - tw * 0.5, h * 0.7 + th * 0.5 + offset)
                surface.DrawText(line)
                offset = offset + th + 8
            end
        end
    end

    local function fadeIn()
        fade:AlphaTo(255, self.fadeDelay, 0)
    end

    local function fadeOut()
        fade:AlphaTo(0, self.fadeDelay, 0)
    end

    local function setImage(url)
        if url then
            html:SetHTML(string.format([[
<html><body style="margin:0;padding:0;overflow:hidden;">
    <img src="%s" width="%d" height="%d"/>
</body></html>]], url, w, h * 0.75))
        else
            html:SetHTML("")
        end
    end

    local function startSubtitle(s)
        if s.sound then surface.PlaySound(s.sound) end
        pl.scene = {
            subtitle = s.text,
            color = s.color,
            font = s.font
        }
    end

    local function endScene(last)
        panel:Remove()
        fadeOut()
        if last.songFade and lia.cutsceneMusic then
            timer.Create("cutSongFade", 0.5, 5, function()
                if not lia.cutsceneMusic then return end
                local v = 0.5 - (5 - timer.RepsLeft("cutSongFade")) * 0.1
                if lia.cutsceneMusic.SetVolume then
                    lia.cutsceneMusic:SetVolume(v)
                else
                    lia.cutsceneMusic:ChangeVolume(v)
                end

                if lia.cutsceneMusic:GetVolume() == 0 then
                    lia.cutsceneMusic:Stop()
                    lia.cutsceneMusic = nil
                end
            end)
        end

        timer.Simple(self.fadeDelay, function()
            fade:Remove()
            hook.Run("CutsceneEnded", id)
        end)
    end

    local t = self.fadeDelay
    for _, scene in SortedPairs(cs) do
        t = t + self.fadeDelay
        scene.startTime = t
        for _, sub in pairs(scene.subtitles) do
            sub.startTime = t
            t = t + sub.duration
        end

        t = t + self.fadeDelay
    end

    fadeIn()
    for idx, scene in SortedPairs(cs) do
        timer.Simple(scene.startTime, function()
            fadeOut()
            cutStarted = true
            setImage(scene.image)
            if scene.sound then
                if lia.cutsceneMusic then
                    lia.cutsceneMusic:Stop()
                    lia.cutsceneMusic = nil
                end

                if scene.sound:find("http") then
                    sound.PlayURL(scene.sound, "noplay", function(m)
                        if not m then return end
                        m:SetVolume(0.5)
                        lia.cutsceneMusic = m
                        m:Play()
                    end)
                else
                    lia.cutsceneMusic = CreateSound(pl, scene.sound)
                    lia.cutsceneMusic:PlayEx(1, 100)
                end
            end
        end)

        for i, sub in SortedPairs(scene.subtitles) do
            timer.Simple(sub.startTime, function()
                startSubtitle(sub)
                if i == #scene.subtitles then
                    fadeIn()
                    timer.Simple(self.fadeDelay, function()
                        setImage()
                        pl.scene = nil
                        if idx == #cs then endScene(scene) end
                    end)
                end
            end)
        end
    end
end

net.Receive("lia_cutscene", function()
    local id = net.ReadString()
    MODULE:runCutscene(id)
end)
