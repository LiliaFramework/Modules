function MODULE:LoadCharInformation()
    local client = LocalPlayer()
    local status, frequency = self:GetPlayerRadioFrequency(client)
    hook.Run("AddTextField", "Radio", "radiostatus", "Radio", function() return status end)
    hook.Run("AddTextField", "Radio", "radiofrequency", "Frequency", function() return frequency end)
end

function MODULE:GetPlayerRadioFrequency(client)
    local char = client:getChar()
    if not char then return "This radio isn't yours.", "000.0" end
    local inv = char:getInv()
    if not inv then return "This radio isn't yours.", "000.0" end
    local radio = inv:getFirstItemOfType("radio")
    if not radio then return "This radio isn't yours.", "000.0" end
    local status = radio:getData("enabled") and "on" or "off"
    local frequency = radio:getData("freq", "000.0")
    return status, frequency
end

lia.font.register("liaDialFont", {
    font = "Montserrat Medium",
    size = math.max(ScreenScale(7), 17),
    weight = 100
})

lia.font.register("liaRadioFont", {
    font = "Lucida Sans Typewriter",
    size = math.max(ScreenScale(7), 17),
    weight = 100
})
