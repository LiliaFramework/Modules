lia.command.add("afktoggle", {
    adminOnly = true,
    arguments = {
        {
            name = "player",
            type = "player"
        }
    },
    desc = "Toggle AFK status on a player",
    onRun = function(client, arguments)
        local target = lia.util.findPlayer(client, arguments[1])
        if not IsValid(target) then return "@invalidTarget" end
        if not lia.config.get("AFKProtectionEnabled", true) then return "AFK protection is disabled." end
        local isAFK = target:getNetVar("isAFK", false)
        if isAFK then
            target:setNetVar("isAFK", false)
            target:setNetVar("lastActivity", CurTime())
            client:notify("Removed AFK status from " .. target:Name())
            target:notify("Your AFK status has been removed by an admin.")
        else
            target:setNetVar("isAFK", true)
            target:setNetVar("afkTime", CurTime())
            client:notify("Set AFK status on " .. target:Name())
            target:notify("You have been marked as AFK by an admin.")
        end
    end
})

lia.command.add("afkstatus", {
    adminOnly = true,
    arguments = {
        {
            name = "player",
            type = "player",
            optional = true
        }
    },
    desc = "Check AFK status of a player or all players",
    onRun = function(client, arguments)
        if not lia.config.get("AFKProtectionEnabled", true) then return "AFK protection is disabled." end
        local target = arguments[1] and lia.util.findPlayer(client, arguments[1])
        if target then
            local isAFK = target:getNetVar("isAFK", false)
            local lastActivity = target:getNetVar("lastActivity", 0)
            local afkTime = target:getNetVar("afkTime", 0)
            local timeSinceActivity = CurTime() - lastActivity
            local timeAFK = isAFK and (CurTime() - afkTime) or 0
            local status = isAFK and "AFK" or "Active"
            client:notify(string.format("%s: %s (Last Activity: %.1fs ago, AFK Time: %.1fs)", target:Name(), status, timeSinceActivity, timeAFK))
        else
            local afkPlayers = {}
            local activePlayers = {}
            for _, ply in ipairs(player.GetAll()) do
                if IsValid(ply) then
                    local isAFK = ply:getNetVar("isAFK", false)
                    local lastActivity = ply:getNetVar("lastActivity", 0)
                    local timeSinceActivity = CurTime() - lastActivity
                    if isAFK then
                        local afkTime = ply:getNetVar("afkTime", 0)
                        local timeAFK = CurTime() - afkTime
                        table.insert(afkPlayers, string.format("%s (%.1fs)", ply:Name(), timeAFK))
                    else
                        table.insert(activePlayers, string.format("%s (%.1fs ago)", ply:Name(), timeSinceActivity))
                    end
                end
            end

            client:notify("=== AFK Status ===")
            if #afkPlayers > 0 then
                client:notify("AFK Players: " .. table.concat(afkPlayers, ", "))
            else
                client:notify("No players are currently AFK")
            end

            if #activePlayers > 0 then client:notify("Active Players: " .. table.concat(activePlayers, ", ")) end
        end
    end
})