--------------------------------------------------------------------------------------------------------
local MODULE = MODULE
--------------------------------------------------------------------------------------------------------
function MODULE:Check4DonationSWEP(client)
    local weps = lia.config.DonatorWeapons[client:SteamID()] or {}
    for _, wep in ipairs(weps) do
        client:Give(wep)
    end
end

--------------------------------------------------------------------------------------------------------
function MODULE:PlayerSpawn(client)
    if not client:getChar() then return end
    self:Check4DonationSWEP(client)
end
--------------------------------------------------------------------------------------------------------
