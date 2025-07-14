local blurGoal, blurValue = 0, 0
local vignetteAlphaGoal, vignetteAlphaDelta = 0, 0
local hasVignetteMaterial = lia.util.getMaterial("lilia/gui/vignette.png") ~= "___error"
local mathApproach = math.Approach
local function DrawFPS()
    hook.Run("HUDExtrasPreDrawFPS")
    local fpsFont = lia.config.get("FPSHudFont")
    local f = math.Round(1 / FrameTime())
    local minF = MODULE.minFPS or 60
    local maxF = MODULE.maxFPS or 100
    MODULE.barH = MODULE.barH or 1
    MODULE.barH = mathApproach(MODULE.barH, f / maxF * 100, 0.5)
    if f > maxF then MODULE.maxFPS = f end
    if f < minF then MODULE.minFPS = f end
    local x = ScrW() - 10
    local centerY = ScrH() / 2
    draw.SimpleText(f .. " FPS", fpsFont, x, centerY + 20, Color(255, 255, 255), TEXT_ALIGN_RIGHT, 1)
    draw.RoundedBox(0, x - 20, centerY - MODULE.barH, 20, MODULE.barH, Color(255, 255, 255))
    draw.SimpleText("Max : " .. MODULE.maxFPS, fpsFont, x, centerY + 40, Color(150, 255, 150), TEXT_ALIGN_RIGHT, 1)
    draw.SimpleText("Min : " .. MODULE.minFPS, fpsFont, x, centerY + 55, Color(255, 150, 150), TEXT_ALIGN_RIGHT, 1)
    hook.Run("HUDExtrasPostDrawFPS")
end

lia.config.add("FPSHudFont", "FPS HUD Font", "PoppinsMedium", function()
    if not CLIENT then return end
    hook.Run("RefreshFonts")
end, {
    desc = "Font used for the FPS display",
    category = "Fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}
})

local function DrawVignette()
    if hasVignetteMaterial then
        hook.Run("HUDExtrasPreDrawVignette")
        local ft = FrameTime()
        local w, h = ScrW(), ScrH()
        vignetteAlphaDelta = mathApproach(vignetteAlphaDelta, vignetteAlphaGoal, ft * 30)
        surface.SetDrawColor(0, 0, 0, 175 + vignetteAlphaDelta)
        surface.SetMaterial(lia.util.getMaterial("lilia/gui/vignette.png"))
        surface.DrawTexturedRect(0, 0, w, h)
        hook.Run("HUDExtrasPostDrawVignette")
    end
end

local function DrawBlur()
    local client = LocalPlayer()
    hook.Run("HUDExtrasPreDrawBlur")
    blurGoal = client:getLocalVar("blur", 0) + (hook.Run("AdjustBlurAmount", blurGoal) or 0)
    if blurValue ~= blurGoal then blurValue = mathApproach(blurValue, blurGoal, FrameTime() * 20) end
    if blurValue > 0 and not client:ShouldDrawLocalPlayer() then lia.util.drawBlurAt(0, 0, ScrW(), ScrH(), blurValue) end
    if blurValue > 0 then hook.Run("HUDExtrasPostDrawBlur", blurValue) end
end

local function ShouldDrawBlur()
    local hookResult = hook.Run("ShouldDrawBlur")
    if hookResult ~= nil then return hookResult end
    return LocalPlayer():Alive()
end

local function canDrawWatermark()
    local hookResult = hook.Run("ShouldDrawWatermark")
    if hookResult ~= nil then return hookResult end
    return lia.config.get("WatermarkEnabled", false) and isstring(lia.config.get("GamemodeVersion", "")) and lia.config.get("GamemodeVersion", "") ~= "" and isstring(lia.config.get("WatermarkLogo", "")) and lia.config.get("WatermarkLogo", "") ~= ""
end

local function drawWatermark()
    hook.Run("HUDExtrasPreDrawWatermark")
    local w, h = 64, 64
    local logoPath = lia.config.get("WatermarkLogo", "")
    local ver = tostring(lia.config.get("GamemodeVersion", ""))
    if logoPath ~= "" then
        local logo = lia.util.getMaterial(logoPath, "smooth")
        surface.SetMaterial(logo)
        surface.SetDrawColor(255, 255, 255, 80)
        surface.DrawTexturedRect(5, ScrH() - h - 5, w, h)
    end

    if ver ~= "" then
        surface.SetFont("liaHugeFont")
        local _, ty = surface.GetTextSize(ver)
        surface.SetTextColor(255, 255, 255, 80)
        surface.SetTextPos(15 + w, ScrH() - h / 2 - ty / 2)
        surface.DrawText(ver)
    end
    hook.Run("HUDExtrasPostDrawWatermark")
end

function MODULE:HUDPaint()
    local client = LocalPlayer()
    if client:Alive() and client:getChar() then
        if lia.option.get("FPSDraw", false) then DrawFPS() end
        if lia.config.get("Vignette", true) then DrawVignette() end
        if canDrawWatermark() then drawWatermark() end
    end
end

function MODULE:HUDPaintBackground()
    if ShouldDrawBlur() then DrawBlur() end
end

timer.Create("liaVignetteChecker", 1, 0, function()
    local client = LocalPlayer()
    if IsValid(client) then
        local d = {}
        d.start = client:GetPos()
        d.endpos = d.start + Vector(0, 0, 768)
        d.filter = client
        local tr = util.TraceLine(d)
        if tr and tr.Hit then
            vignetteAlphaGoal = 80
        else
            vignetteAlphaGoal = 0
        end
    end
end)
