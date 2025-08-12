local MODULE = MODULE
function MODULE:CanPlayerViewInventory()
    local client = LocalPlayer()
    if not (IsValid(client) and client.getChar and client:getChar()) then return end
    if client:IsBeingSearched() then return false end
end

function MODULE:DrawCharInfo(client, _, info)
    if not IsValid(client) then return end
    local character = client:getChar()
    if not character then return end
    if client:IsHandcuffed() and client:IsBeingSearched() then info[#info + 1] = {L("beingSearched"), Color(245, 215, 110)} end
end