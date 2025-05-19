function MODULE:DrawCharInfo(client, _, info)
    if client:IsHandcuffed() then info[#info + 1] = {L("isTied"), Color(245, 215, 110)} end
end

function MODULE:HUDPaintBackground()
    if not LocalPlayer().getChar(LocalPlayer()) then return end
    if LocalPlayer():IsHandcuffed() then lia.util.drawText(L"restricted", ScrW() * 0.5, ScrH() * 0.33, nil, 1, 1, "liaBigFont") end
end

function MODULE:PlayerBindPress(_, bind, _)
    if LocalPlayer():IsHandcuffed() and (bind == "+jump" or bind == "+speed") then return true end
end