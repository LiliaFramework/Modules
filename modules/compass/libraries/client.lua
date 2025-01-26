lia.option.add("compassActive", "Toggle Compass", "Enable or disable the compass", true, nil, {
    category = "HUD",
    type = "Boolean",
    IsQuick = true
})

local compassText = {
    [0] = "N",
    [45] = "NE",
    [90] = "E",
    [135] = "SE",
    [180] = "S",
    [-180] = "S",
    [-135] = "SW",
    [-90] = "W",
    [-45] = "NW",
}

function MODULE:HUDPaint()
    local scrW, scrH = ScrW(), ScrH()
    local client = LocalPlayer()
    if not IsValid(client) or not client:Alive() then return end
    if not lia.option.get("compassActive") then return end
    local w, h = scrW * 0.4, 30
    local x, y = (scrW * 0.5) - (w * 0.5), scrH - h - 10
    draw.RoundedBox(8, x, y, w, h, Color(0, 0, 0, 180))
    local yaw = math.Round(client:EyeAngles().y)
    for i = yaw - 90, yaw + 90, 15 do
        local angle = i
        if angle > 180 then
            angle = angle - 360
        elseif angle < -180 then
            angle = angle + 360
        end

        if compassText[angle] then
            local offsetX = ((i - yaw) * (w / 180)) + (w * 0.5)
            draw.SimpleText(compassText[angle], "liaMediumFont", x + offsetX, y + h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end
