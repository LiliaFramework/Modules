function MODULE:LoadFonts()
    surface.CreateFont("liaDialFont", {
        font = "Arial",
        size = 20,
        weight = 500,
        antialias = true,
        shadow = false
    })

    surface.CreateFont("liaRadioFont", {
        font = "Lucida Sans Typewriter",
        size = math.max(ScreenScale(7), 17),
        weight = 100
    })
end

function MODULE:LoadCharInformation()
    local client = LocalPlayer()
    hook.Run("AddSection", "Radio", Color(0, 0, 0), 8)
    local status, frequency = self:GetPlayerRadioFrequency(client)
    hook.Run("AddTextField", "Radio", "radiostatus", "Radio", function() return status end)
    hook.Run("AddTextField", "Radio", "radiofrequency", "Frequency", function() return frequency end)
end

function MODULE:GetPlayerRadioFrequency(player)
    local char = player:getChar()
    if not char then return end
    local radio = char:getInv():getFirstItemOfType("radio")
    if not radio then return "You don't own a radio!", "000.0" end
    local status = radio:getData("enabled") and "On" or "Off"
    local frequency = radio:getData("freq", "000.0")
    return status, frequency
end