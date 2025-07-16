function MODULE:RenderScreenspaceEffects()
    if LocalPlayer():getNetVar("lia_alcoholism_bac", 0) > 0 then DrawMotionBlur(lia.config.get("AlcoholAddAlpha"), LocalPlayer():getNetVar("lia_alcoholism_bac", 0) / 100, lia.config.get("AlcoholEffectDelay")) end
end

function MODULE:DrawCharInfo(client, _, info)
    if client:IsDrunk() then info[#info + 1] = {L("intoxicatedStatus"), Color(245, 215, 110)} end
end

function MODULE:LoadCharInformation()
    hook.Run("AddTextField", L("generalinfo"), "drunkness", L("drunkness"), function() return LocalPlayer():getNetVar("lia_alcoholism_bac", 0) .. "%" end)
end