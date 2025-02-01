function MODULE:PlayerLoadedChar(client, char)
    local usergroup = client:GetUserGroup()
    local group = self.DonatorGroups[usergroup]
    if group then char:giveFlags(group) end
end

function MODULE:PlayerSpawn(client)
    local maxCharDonation = lia.data.get("charslotsteamids", {}, nil, true)
    if maxCharDonation[client:SteamID()] then
        MsgC(Color(0, 255, 0), "Player " .. client:Nick() .. " previously donated and has " .. maxCharDonation[client:SteamID()] .. " slots\n")
        client:setNetVar("overrideSlots", maxCharDonation[client:SteamID()])
    end
end

function AddOverrideCharSlots(client)
    for _, ply in player.Iterator() do
        if client and ply == client then
            local contents = lia.data.get("charslotsteamids", {}, nil, true)
            if contents[ply:SteamID()] then
                contents[ply:SteamID()] = contents[ply:SteamID()] + 1
            else
                contents[ply:SteamID()] = lia.config.get("MaxCharacters") + 1
            end

            lia.data.set("charslotsteamids", contents, nil, true)
            ply:setNetVar("overrideSlots", contents[ply:SteamID()])
        end
    end
end

function SubtractOverrideCharSlots(client)
    for _, ply in player.Iterator() do
        if client and ply == client then
            local contents = lia.data.get("charslotsteamids", {}, nil, true)
            if contents[ply:SteamID()] then
                contents[ply:SteamID()] = contents[ply:SteamID()] - 1
            else
                contents[ply:SteamID()] = lia.config.get("MaxCharacters")
            end

            lia.data.set("charslotsteamids", contents, nil, true)
            ply:setNetVar("overrideSlots", contents[ply:SteamID()])
        end
    end
end

function OverrideCharSlots(client, value)
    for _, ply in player.Iterator() do
        if client and ply == client then
            local contents = lia.data.get("charslotsteamids", {}, nil, true)
            if contents[ply:SteamID()] then
                contents[ply:SteamID()] = value
            else
                contents[ply:SteamID()] = value
            end

            lia.data.set("charslotsteamids", contents, nil, true)
            ply:setNetVar("overrideSlots", contents[ply:SteamID()])
        end
    end
end
