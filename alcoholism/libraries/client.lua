-- Alcohol config locals
local AlcoholAddAlpha = 0.03
local AlcoholEffectDelay = 0.03

function MODULE:RenderScreenspaceEffects()
    if LocalPlayer():getLocalVar("bac", 0) > 0 then DrawMotionBlur(AlcoholAddAlpha, LocalPlayer():getLocalVar("bac", 0) / 100, AlcoholEffectDelay) end
end

function MODULE:LoadCharInformation()
    hook.Run("AddTextField", L("generalinfo"), "drunkness", L("drunkness"), function() return LocalPlayer():getLocalVar("bac", 0) .. "%" end)
end
