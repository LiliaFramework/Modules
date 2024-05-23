function MODULE:PostRenderVGUI()
    if ScreamerEffectEnabled then
        surface.SetDrawColor(math.random(0, 255), math.random(0, 255), math.random(0, 255), 255)
        surface.DrawRect(0, 0, ScrW(), ScrH())
    end
end