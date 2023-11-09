--------------------------------------------------------------------------------------------------------
local MODULE = MODULE
--------------------------------------------------------------------------------------------------------
function MODULE:DrawCharInfo(client, character, info)
    local tier = character:getData("party_tier", 0)
    if tier == 1 then
        info[#info + 1] = {"Tier I Party Member", Color(255, 209, 20)}
    elseif tier == 2 then
        info[#info + 1] = {"Tier II Party Member", Color(255, 209, 20)}
    elseif tier == 3 then
        info[#info + 1] = {"Tier III Party Member", Color(255, 209, 20)}
    elseif tier == 4 then
        info[#info + 1] = {"Tier IV Party Member", Color(255, 209, 20)}
    elseif tier == 5 then
        info[#info + 1] = {"Tier V Party Member", Color(255, 209, 20)}
    end
end
--------------------------------------------------------------------------------------------------------