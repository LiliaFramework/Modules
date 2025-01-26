local DonatorWeapons = {
    ["76561198312513285"] = {"weapon_smg1", "weapon_shotgun", "weapon_rpg", "weapon_pistol"},
    ["steamid64"] = {"weaponid", "", "", ""},
}

function MODULE:Check4DonationSWEP(client)
    local weps = DonatorWeapons[client:SteamID64()]
    for _, wep in ipairs(weps) do
        client:Give(wep)
    end
end

function MODULE:PlayerSpawn(client)
    if not client:getChar() then return end
    self:Check4DonationSWEP(client)
end
