lia.command.add("afktoggle", {
    adminOnly = true,
    arguments = {
        {
            name = "player",
            type = "player"
        }
    },
    desc = L("afkCommandDesc"),
    onRun = function(client, arguments)
        local target = lia.util.findPlayer(client, arguments[1])
        if not IsValid(target) then return "@invalidTarget" end
        if not lia.config.get("AFKProtectionEnabled", true) then return L("afkProtectionDisabled") end
        local isAFK = target:getNetVar("isAFK", false)
        if isAFK then
            target:setNetVar("isAFK", false)
            target:setNetVar("lastActivity", CurTime())
            client:notify(L("afkStatusRemoved", target:Name()))
            target:notify(L("afkStatusRemovedByAdmin"))
        else
            target:setNetVar("isAFK", true)
            target:setNetVar("afkTime", CurTime())
            client:notify(L("afkStatusSet", target:Name()))
            target:notify(L("afkStatusSetByAdmin"))
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
    desc = L("afkStatusCommandDesc"),
    onRun = function(client, arguments)
        if not lia.config.get("AFKProtectionEnabled", true) then return L("afkProtectionDisabled") end
        local target = arguments[1] and lia.util.findPlayer(client, arguments[1])
        if target then
            local isAFK = target:getNetVar("isAFK", false)
            local lastActivity = target:getNetVar("lastActivity", 0)
            local afkTime = target:getNetVar("afkTime", 0)
            local timeSinceActivity = CurTime() - lastActivity
            local timeAFK = isAFK and (CurTime() - afkTime) or 0
            local status = isAFK and L("afkStatus") or L("activePlayers")
            client:notify(string.format("%s: %s (" .. L("lastActivity") .. ": %.1fs ago, " .. L("afkTimeLabel") .. ": %.1fs)", target:Name(), status, timeSinceActivity, timeAFK))
        else
            local afkPlayers = {}
            local activePlayers = {}
            for _, ply in player.Iterator() do
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

            client:notify(L("afkStatus"))
            if #afkPlayers > 0 then
                client:notify(L("afkPlayers") .. ": " .. table.concat(afkPlayers, ", "))
            else
                client:notify(L("noPlayersAFK"))
            end

            if #activePlayers > 0 then client:notify(L("activePlayers") .. ": " .. table.concat(activePlayers, ", ")) end
        end
    end
})
