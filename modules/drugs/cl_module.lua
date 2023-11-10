-------------------------------------------------------------------------------------------
function MODULE:Think()
    local client = LocalPlayer()
    if client:getChar() and (client.nextDrugCheck or 0) < CurTime() then
        client.nextDrugCheck = CurTime() + 5
        local glare = LocalPlayer():getNetVar("glare")
        if glare then
            self.glare = glare
        else
            self.glare = nil
        end
    elseif not client:getChar() then
        self.glare = nil
    end
end

-------------------------------------------------------------------------------------------
function MODULE:RenderScreenspaceEffects()
    if self.glare then
        local colorMod = {}
        colorMod["$pp_colour_addr"] = 0
        colorMod["$pp_colour_addg"] = 0
        colorMod["$pp_colour_addb"] = 0
        colorMod["$pp_colour_brightness"] = self.glare
        colorMod["$pp_colour_contrast"] = 1
        colorMod["$pp_colour_colour"] = 1
        colorMod["$pp_colour_mulr"] = 1
        colorMod["$pp_colour_mulg"] = 1
        colorMod["$pp_colour_mulb"] = 1
        DrawColorModify(colorMod)
    end
end
-------------------------------------------------------------------------------------------
