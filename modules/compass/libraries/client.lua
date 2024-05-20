local CompassActive = CreateClientConVar("lia_compass", 1, true, true)
function MODULE:HUDPaint()
    local scrW, scrH = ScrW(), ScrH()
    local client = LocalPlayer()
    if not IsValid(client) or not client:Alive() then return end
    if CompassActive:GetBool() == false then return end
    local w, h = scrW * .4, 30
    local x, y = (scrW * .5) - (w * .5), scrH - h
    draw.RoundedBox(8, x, y, w, h, Color(0, 0, 0, 180))
    local finalText = ""
    local yaw = math.floor(client:GetAngles().y)
    for i = yaw - 39, yaw + 39 do
        local y = i
        if i > 180 then
            y = -360 + i
        elseif i < -180 then
            y = 360 + i
        end

        finalText = (self.compassText[y] and self.compassText[y] .. finalText) or " " .. finalText
    end

    draw.DrawText(finalText, "liaMediumFont", x, y, color_white)
end

function MODULE:SetupQuickMenu(menu)
    menu:addCheck("Toggle compass", function(_, state) RunConsoleCommand("lia_compass", state and "1" or "0") end, CompassActive:GetBool())
    menu:addSpacer()
end
