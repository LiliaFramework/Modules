function MODULE:CanPlayerViewInventory()
    if LocalPlayer():IsBeingSearched() then return false end
end

function MODULE:DrawCharInfo(client, _, info)
    if client:IsHandcuffed() and client:IsBeingSearched() then info[#info + 1] = {L("beingSearched"), Color(245, 215, 110)} end
end