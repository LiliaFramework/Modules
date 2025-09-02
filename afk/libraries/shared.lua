local MODULE = MODULE
local playerMeta = FindMetaTable("Player")
function playerMeta:isAFK()
    return self:getNetVar("AFK", false) and true or false
end

function playerMeta:getAFKMinutes()
    local since = self:getNetVar("AFKStart", nil)
    if not since then return 0 end
    local diff = os.time() - tonumber(since)
    if diff < 0 then diff = 0 end
    return math.floor(diff / 60)
end

lia.config.add("AFKTimeMinutes", "afkTimeMinutes", 5, function(_, _) if CLIENT then MODULE:RestartAFKTimer() end end, {
    desc = "Time in minutes before a player is marked as AFK",
    category = "AFK System",
    type = "Int",
    min = 1,
    max = 60
})

lia.command.add("forceafk", {
    desc = "Force set a player as AFK or remove their AFK status.",
    adminOnly = true,
    AdminStick = {
        Name = "Force AFK",
        Category = "Player Management",
        Icon = "icon16/user_comment.png"
    },
    onRun = function(client, arguments)
        local targetName = arguments[1]
        if not targetName then return client:notify("Usage: /forceafk <player name>") end
        local target = lia.util.findPlayer(client, targetName)
        if not IsValid(target) then return client:notify("Player not found.") end
        local isCurrentlyAFK = target:getNetVar("AFK", false)
        if isCurrentlyAFK then
            markAFK(target, false)
            client:notify(string.format("Removed AFK status from %s.", target:Nick()))
            target:notify("An admin has removed your AFK status.")
        else
            markAFK(target, true)
            client:notify(string.format("Set %s as AFK.", target:Nick()))
            target:notify("An admin has forced you into AFK status.")
        end
    end
})