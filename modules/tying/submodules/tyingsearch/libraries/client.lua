function MODULE:CanPlayerViewInventory()
    if IsBeingSearched(LocalPlayer()) then return false end
end

function MODULE:DrawCharInfo(client, _, info)
    if IsHandcuffed(client) and IsBeingSearched(client) then info[#info + 1] = {L"beingSearched", Color(245, 215, 110)} end
end