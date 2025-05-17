function MODULE:HUDPaint()
    local client = LocalPlayer()
    if not IsValid(client:getChar()) then return end
    local devFont = lia.config.get("DevHudFont")
    local x = ScrW() / 5.25
    local baseY = ScrH() / 1.12
    if client:hasPrivilege("Staff Permissions - Development HUD") then draw.SimpleText("| " .. client:SteamID64() .. " | " .. client:SteamID() .. " | " .. os.date("%m/%d/%Y | %X", os.time()) .. " | ", devFont, x, baseY, Color(210, 210, 210, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) end
    if client:hasPrivilege("Staff Permissions - Staff HUD") then
        local trace = client:GetEyeTraceNoCursor()
        local hitPos = trace.HitPos
        local ent = trace.Entity
        local y1 = ScrH() / 1.10
        local y2 = ScrH() / 1.08
        local y3 = ScrH() / 1.06
        draw.SimpleText("| Pos: " .. math.Round(client:GetPos().x, 2) .. "," .. math.Round(client:GetPos().y, 2) .. "," .. math.Round(client:GetPos().z, 2) .. " | Angle: " .. math.Round(client:GetAngles().x, 2) .. "," .. math.Round(client:GetAngles().y, 2) .. "," .. math.Round(client:GetAngles().z, 2) .. " | FPS: " .. math.Round(1 / FrameTime(), 0) .. " | Trace Dis: " .. math.Round(client:GetPos():Distance(hitPos), 2) .. " | ", devFont, x, y1, Color(210, 210, 210, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("| Trace Pos: " .. math.Round(hitPos.x, 2) .. "," .. math.Round(hitPos.y, 2) .. "," .. math.Round(hitPos.z, 2) .. " | Cur Health: " .. math.Round(client:Health(), 2) .. " | FrameTime: " .. FrameTime() .. " | PING: " .. client:Ping() .. " | ", devFont, x, y2, Color(210, 210, 210, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        if IsValid(ent) then draw.SimpleText("| Cur Trace: " .. ent:GetClass() .. " | Trace Model: " .. (ent.GetModel and ent:GetModel() or "N/A") .. " | ", devFont, x, y3, Color(210, 210, 210, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) end
    end
end