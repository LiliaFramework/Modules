function MODULE:DrawCharInfo(client, character, info)
    if not IsHandcuffed(client) then return end
    if IsBlinded(client) then info[#info + 1] = {"Blindfolded", Color(245, 215, 110)} end
    if IsGagged(client) then info[#info + 1] = {"Gagged", Color(245, 215, 110)} end
end

function MODULE:RenderScreenspaceEffects()
    local client = LocalPlayer()
    if IsHandcuffed(client) and IsBlinded(client) then
        surface.SetDrawColor(Color(0, 0, 0, 255))
        surface.DrawRect(0, 0, ScrW(), ScrH())
    end
end
