local SteamGroupRewardList = SteamGroupRewardList or {}
local MODULE = MODULE
local function SteamGroup_SendClaim(ply)
    local char = ply:getChar()
    if not char then return end
    char:giveMoney(MODULE.MoneyReward)
    ply:notify("You have received " .. lia.currency.get(MODULE.MoneyReward) .. " for joining the steam group!")
    char:setGroupClaimed(true)
end

function SteamGroup_TryClaim(ply)
    local char = ply:getChar()
    if char:getGroupClaimed() then
        ply:notify("You've already claimed this reward.")
        return
    end

    if SteamGroupRewardList[ply:SteamID64()] then
        SteamGroup_SendClaim(ply)
        return
    end

    if SteamGroup_LastManualCheck == nil or SysTime() > SteamGroup_LastManualCheck + 60 then
        SteamGroup_LastManualCheck = SysTime()
        SteamGroup_PerformCheck()
    else
        ply:notify("Manual check system too busy. Try again in " .. 60 .. "s or wait for automatic check (every " .. 300 .. "s)")
    end
end

local function SteamGroup_ProccessPageData(body)
    if not body then return 0 end
    local count = 0
    for steamID in body:gmatch("<steamID64>(%d+)</steamID64>") do
        if steamID and steamID ~= "" then
            SteamGroupRewardList_Temp[steamID] = true
            count = count + 1
        end
    end
    return count
end

local function SteamGroup_PerformCheck()
    local group = MODULE.GroupID
    if not group or group == "" then return end
    http.Fetch("https://steamcommunity.com/groups/" .. group .. "/memberslistxml/?xml=1&p=1", function(body)
        SteamGroupRewardList_Temp = {}
        local totalMembers = SteamGroup_ProccessPageData(body)
        local pagesAccountedFor = 1
        local _, _, pgCount = body:find("<totalPages>(%d+)")
        pgCount = tonumber(pgCount)
        if not pgCount then return end
        for i = 2, pgCount do
            http.Fetch("https://steamcommunity.com/groups/" .. group .. "/memberslistxml/?xml=1&p=" .. i, function(body_s)
                local countR = SteamGroup_ProccessPageData(body_s)
                totalMembers = totalMembers + countR
                pagesAccountedFor = pagesAccountedFor + 1
                if pagesAccountedFor == pgCount then
                    SteamGroupRewardList = table.Copy(SteamGroupRewardList_Temp)
                    SteamGroupRewardList_Temp = nil
                end
            end)
        end
    end)
end

local function SteamGroup_CreateTimer()
    timer.Create("SteamGroup_AutomaticRequestDelay", 300, 0, SteamGroup_PerformCheck)
end

lia.command.add("group", {
    desc = "Opens the Steam group page for joining",
    onRun = function(client)
        net.Start("sgrMenuCheck")
        net.Send(client)
        client:notify("Once you have joined the group, type !claim to make a request to check for group rewards immediately.")
    end
})

lia.command.add("claim", {
    desc = "Claim Steam group rewards",
    onRun = function(client) SteamGroup_TryClaim(client) end
})

lia.char.registerVar("groupClaimed", {
    field = "groupclaimed",
    fieldType = "boolean",
    default = false,
    noDisplay = true
})

SteamGroup_CreateTimer()