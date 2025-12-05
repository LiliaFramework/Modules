local MODULE = MODULE
function MODULE:PlayerLoadedChar(client, char)
    local usergroup = client:GetUserGroup()
    local group = self.DonatorGroups[usergroup]
    if group then char:giveFlags(group) end
end

function MODULE:PlayerSpawn(client)
    local currentSlots = client:getLiliaData("overrideSlots", nil)
    if currentSlots then MsgC(Color(0, 255, 0), L("donatedSlotsInfo", client:Nick(), currentSlots) .. "\n") end
end

function AddOverrideCharSlots(client)
    for _, ply in player.Iterator() do
        if client and ply == client then
            local current = ply:getLiliaData("overrideSlots", lia.config.get("MaxCharacters"))
            current = current + 1
            ply:setLiliaData("overrideSlots", current)
        end
    end
end

function MODULE:GetDefaultInventorySize(client)
    local grp = client:GetUserGroup()
    local sz = self.GroupInventorySize[grp]
    if sz then return sz[1], sz[2] end
end

function SubtractOverrideCharSlots(client)
    for _, ply in player.Iterator() do
        if client and ply == client then
            local current = ply:getLiliaData("overrideSlots", lia.config.get("MaxCharacters"))
            current = current - 1
            ply:setLiliaData("overrideSlots", current)
        end
    end
end

function OverrideCharSlots(client, value)
    for _, ply in player.Iterator() do
        if client and ply == client then ply:setLiliaData("overrideSlots", value) end
    end
end

local function consoleFindPlayer(name)
    local dummy = {}
    function dummy:notifyLocalized(msg)
    end
    return lia.util.findPlayer(dummy, name)
end

concommand.Add("lia_givecharacters", function(ply, _, args)
    if IsValid(ply) then return end
    local steamid = args[1]
    local count = tonumber(args[2])
    if not steamid or not count then return end
    local target = consoleFindPlayer(steamid)
    if not IsValid(target) then return end
    target:giveAdditionalCharSlots(count)
end)

concommand.Add("lia_givemoney", function(ply, _, args)
    if IsValid(ply) then return end
    local steamid = args[1]
    local amount = tonumber(args[2])
    if not steamid or not amount then return end
    local target = consoleFindPlayer(steamid)
    if not IsValid(target) then return end
    local char = target:getChar()
    if not char then return end
    char:giveMoney(amount)
end)

concommand.Add("lia_giveflags", function(ply, _, args)
    if IsValid(ply) then return end
    local steamid = args[1]
    local flags = args[2]
    if not steamid or not flags then return end
    local target = consoleFindPlayer(steamid)
    if not IsValid(target) then return end
    local char = target:getChar()
    if not char then return end
    char:giveFlags(flags)
end)

concommand.Add("lia_giveitem", function(ply, _, args)
    if IsValid(ply) then return end
    local steamid = args[1]
    local uniqueID = args[2]
    if not steamid or not uniqueID then return end
    local target = consoleFindPlayer(steamid)
    if not IsValid(target) then return end
    local char = target:getChar()
    if not char then return end
    local inv = char:getInv()
    if not inv then return end
    inv:add(uniqueID)
end)
