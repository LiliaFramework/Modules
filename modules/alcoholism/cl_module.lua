--------------------------------------------------------------------------------------------------------
function MODULE:RenderScreenspaceEffects()
    local ply = LocalPlayer()
    if ply:GetDrunkLevel() > 0 then DrawMotionBlur(lia.config.AlcoholismAddAlpha, ply:GetDrunkLevel() / 100, lia.config.AlcoholismEffectDelay) end
end

--------------------------------------------------------------------------------------------------------
function MODULE:DrawCharInfo(client, character, info)
    if client:IsDrunk() then info[#info + 1] = {"This Person Is Heavily Intoxicated", Color(245, 215, 110)} end
end
--------------------------------------------------------------------------------------------------------
