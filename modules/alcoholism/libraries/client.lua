function MODULE:RenderScreenspaceEffects()
    if LocalPlayer():GetNW2Int("lia_alcoholism_bac", 0) > 0 then DrawMotionBlur(self.AddAlpha, LocalPlayer():GetNW2Int("lia_alcoholism_bac", 0) / 100, self.EffectDelay) end
end

function MODULE:DrawCharInfo(client, _, info)
    if client:IsDrunk() then info[#info + 1] = {"This Person Is Heavily Intoxicated", Color(245, 215, 110)} end
end
