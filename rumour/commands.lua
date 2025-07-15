lia.command.add("rumour", {
    adminOnly = false,
    syntax = "[string Message]",
    desc = L("rumourCommandDesc"),
    onRun = function(client, arguments)
        local faction = lia.faction.indices[client:Team()]
        if not faction or not faction.criminal then
            client:ChatPrint(L("rumourNotAllowed"))
            return
        end

        local rumourMessage = table.concat(arguments, " ")
        if rumourMessage == "" then
            client:ChatPrint(L("rumourNoMessage"))
            return
        end

        if hook.Run("CanSendRumour", client, rumourMessage) == false then return end
        if not client.rumourdelay then client.rumourdelay = 0 end
        if CurTime() < client.rumourdelay then
            local seconds = math.ceil(client.rumourdelay - CurTime())
            client:notifyLocalized("commandCooldownTimed", seconds)
            return
        end

        hook.Run("RumourAttempt", client, rumourMessage)
        client.rumourdelay = CurTime() + lia.config.get("RumourCooldown", 60)
        local revealChance = lia.config.get("RumourRevealChance", 0.02)
        local revealMath = math.random() < revealChance
        for _, target in player.Iterator() do
            local targetFaction = lia.faction.indices[target:Team()]
            if targetFaction and targetFaction.criminal then
                ClientAddText(target, L("rumourMessagePrefix", rumourMessage))
            elseif revealMath and targetFaction and targetFaction.police then
                ClientAddText(target, L("rumourMessagePrefix", rumourMessage))
            end
        end

        hook.Run("RumourSent", client, rumourMessage, revealMath)
    end
})
