local MODULE = MODULE
function MODULE:PlayerLoadedChar(client, char)
    local usergroup = client:GetUserGroup()
    local group = self.DonatorGroups[usergroup]
    if group then char:giveFlags(group) end
end

function MODULE:PlayerSpawn(client)
    local currentSlots = client:getLiliaData("overrideSlots", nil)
    if currentSlots then MsgC(Color(0, 255, 0), "Player " .. client:Nick() .. " previously donated and has " .. currentSlots .. " slots\n") end
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
        print(msg)
    end
    return lia.command.findPlayer(dummy, name)
end

concommand.Add("lia_givecharacters", function(ply, _, args)
    if IsValid(ply) then return end
    local steamid = args[1]
    local count = tonumber(args[2])
    if not steamid or not count then
        print("Usage: lia_givecharacters <steamid> <count>")
        return
    end

    local target = consoleFindPlayer(steamid)
    if not IsValid(target) then
        print("Player not found.")
        return
    end

    target:GiveAdditionalCharSlots(count)
    print("Gave " .. count .. " additional character slots to " .. target:Nick())
end)

concommand.Add("lia_givemoney", function(ply, _, args)
    if IsValid(ply) then return end
    local steamid = args[1]
    local amount = tonumber(args[2])
    if not steamid or not amount then
        print("Usage: lia_givemoney <steamid> <amount>")
        return
    end

    local target = consoleFindPlayer(steamid)
    if not IsValid(target) then
        print("Player not found.")
        return
    end

    local char = target:getChar()
    if not char then
        print("Target has no character.")
        return
    end

    char:giveMoney(amount)
    print("Gave " .. amount .. " money to " .. target:Nick())
end)

concommand.Add("lia_giveflags", function(ply, _, args)
    if IsValid(ply) then return end
    local steamid = args[1]
    local flags = args[2]
    if not steamid or not flags then
        print("Usage: lia_giveflags <steamid> <flags>")
        return
    end

    local target = consoleFindPlayer(steamid)
    if not IsValid(target) then
        print("Player not found.")
        return
    end

    local char = target:getChar()
    if not char then
        print("Target has no character.")
        return
    end

    char:giveFlags(flags)
    print("Gave flags " .. flags .. " to " .. target:Nick())
end)

concommand.Add("lia_giveitem", function(ply, _, args)
    if IsValid(ply) then return end
    local steamid = args[1]
    local uniqueID = args[2]
    if not steamid or not uniqueID then
        print("Usage: lia_giveitem <steamid> <item_uniqueID>")
        return
    end

    local target = consoleFindPlayer(steamid)
    if not IsValid(target) then
        print("Player not found.")
        return
    end

    local char = target:getChar()
    if not char then
        print("Target has no character.")
        return
    end

    local inv = char:getInv()
    if not inv then
        print("Target has no inventory.")
        return
    end

    inv:add(uniqueID)
    print("Gave item " .. uniqueID .. " to " .. target:Nick())
end)
