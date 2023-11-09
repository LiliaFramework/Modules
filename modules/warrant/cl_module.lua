--------------------------------------------------------------------------------------------------------
local MODULE = MODULE
--------------------------------------------------------------------------------------------------------
function MODULE:DrawCharInfo(client, character, info)
    local PoliceMan = LocalPlayer():Team() == lia.config.PoliceFaction
    if client:IsWanted() then
        if lia.config.OnlyPoliceSeeWarranted then
            if PoliceMan then
                info[#info + 1] = {"Has Active Warrants", Color(255, 0, 0)}
            end
        else
            info[#info + 1] = {"Has Active Warrants", Color(255, 0, 0)}
        end
    end
end
--------------------------------------------------------------------------------------------------------