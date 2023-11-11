----------------------------------------------------------------------------------------------
function MODULE:CheckPossibilities()
    for k, v in pairs(PIM.options) do
        if not LocalPlayer():GetEyeTrace().Entity:IsPlayer() then return end
        if v.shouldShow(LocalPlayer(), LocalPlayer():GetEyeTrace().Entity) then return true end
    end
    return false
end

----------------------------------------------------------------------------------------------
function MODULE:PlayerBindPress(ply, bind, pressed)
    if bind == "+showscores" and pressed and self:CheckPossibilities() then
        self:OpenPIM()
        return true
    end
end
----------------------------------------------------------------------------------------------
