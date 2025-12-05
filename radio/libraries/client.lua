function MODULE:LoadCharInformation()
    local client = LocalPlayer()
    local status, frequency = self:GetPlayerRadioFrequency(client)
    hook.Run("AddTextField", L("radio"), "radiostatus", L("radio"), function() return status end)
    hook.Run("AddTextField", L("radio"), "radiofrequency", L("frequency"), function() return frequency end)
end

function MODULE:GetPlayerRadioFrequency(client)
    local char = client:getChar()
    if not char then return L("radioNotOwned"), "000.0" end
    local inv = char:getInv()
    if not inv then return L("radioNotOwned"), "000.0" end
    local radio = inv:getFirstItemOfType("radio")
    if not radio then return L("radioNotOwned"), "000.0" end
    local status = radio:getData("enabled") and L("on") or L("off")
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
