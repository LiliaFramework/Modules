function MODULE:RenderScreenspaceEffects()
    if LocalPlayer():getNetVar("lia_alcoholism_bac", 0) > 0 then DrawMotionBlur(lia.config.get("AlcoholAddAlpha"), LocalPlayer():getNetVar("lia_alcoholism_bac", 0) / 100, lia.config.get("AlcoholEffectDelay")) end
end

function MODULE:DrawCharInfo(client, _, info)
    if client:IsDrunk() then info[#info + 1] = {"This Person Is Heavily Intoxicated", Color(245, 215, 110)} end
end

function MODULE:LoadCharInformation()
    local client = LocalPlayer()
    hook.Run("AddTextField", "General Info", "drunkness", "Drunkness Level", function() return LocalPlayer():getNetVar("lia_alcoholism_bac", 0) .. "%" end)
end