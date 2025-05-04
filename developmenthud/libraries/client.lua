﻿
function MODULE:HUDPaint()
    local client = LocalPlayer()
    if not IsValid(client:getChar()) then return end
    if client:hasPrivilege("Staff Permissions - Development HUD") then draw.SimpleText("| " .. client:SteamID64() .. " | " .. client:SteamID() .. " | " .. os.date("%m/%d/%Y | %X", os.time()) .. " | ", "DevHudText", ScrW() / 5.25, ScrH() / 1.12, Color(210, 210, 210, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) end
    if client:hasPrivilege("Staff Permissions - Staff HUD") then
        local trace = client:GetEyeTraceNoCursor()
        local entTrace = trace.Entity
        draw.SimpleText("| Pos: " .. math.Round(client:GetPos().x, 2) .. "," .. math.Round(client:GetPos().y, 2) .. "," .. math.Round(client:GetPos().z, 2) .. " | Angle: " .. math.Round(client:GetAngles().x, 2) .. "," .. math.Round(client:GetAngles().y, 2) .. "," .. math.Round(client:GetAngles().z, 2) .. " | FPS: " .. math.Round(1 / FrameTime(), 0) .. " | Trace Dis: " .. math.Round(client:GetPos():Distance(trace.HitPos), 2) .. " | ", "DevHudText", ScrW() / 5.25, ScrH() / 1.10, Color(210, 210, 210, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("| Trace Pos: " .. math.Round(trace.HitPos.x, 2) .. "," .. math.Round(trace.HitPos.y, 2) .. "," .. math.Round(trace.HitPos.z, 2) .. " | Cur Health: " .. math.Round(client:Health(), 2) .. " | FrameTime: " .. FrameTime() .. " | PING: " .. client:Ping() .. " | ", "DevHudText", ScrW() / 5.25, ScrH() / 1.08, Color(210, 210, 210, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        if IsValid(entTrace) then draw.SimpleText("| Cur Trace: " .. entTrace:GetClass() .. " | Trace Model: " .. entTrace:GetModel() .. " | ", "DevHudText", ScrW() / 5.25, ScrH() / 1.06, Color(210, 210, 210, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) end
    end
end

lia.font.register("DevHudServerName", {
    font = lia.config.get("Font"),
    extended = false,
    size = 20 * ScrH() / 950,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false
})

lia.font.register("DevHudText", {
    font = lia.config.get("Font"),
    extended = false,
    size = 20 * ScrH() / 1000,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false
})