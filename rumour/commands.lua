lia.command.add("rumour", {
    adminOnly = false,
    syntax = "[string Message]",
    desc = L("rumourCommandDesc"),
    onRun = function(client, arguments)
        hook.Run("PreRumourCommand", client, arguments)
        local faction = lia.faction.indices[client:Team()]
        if not faction or not faction.criminal then
            hook.Run("RumourFactionDisallowed", client, faction)
            client:ChatPrint(L("rumourNotAllowed"))
            return
        end

        local rumourMessage = table.concat(arguments, " ")
        if rumourMessage == "" then
            hook.Run("RumourNoMessage", client)
            client:ChatPrint(L("rumourNoMessage"))
            return
        end

        if hook.Run("CanSendRumour", client, rumourMessage) == false then
            hook.Run("RumourValidationFailed", client, rumourMessage)
            return
        end

        if not client.rumourdelay then client.rumourdelay = 0 end
        if CurTime() < client.rumourdelay then
            local seconds = math.ceil(client.rumourdelay - CurTime())
            client:notifyLocalized("rumourCommandCooldownTimed", seconds)
            return
        end

        hook.Run("RumourAttempt", client, rumourMessage)
        client.rumourdelay = CurTime() + lia.config.get("RumourCooldown", 60)
        local revealChance = lia.config.get("RumourRevealChance", 0.02)
        local revealMath = math.random() < revealChance
        hook.Run("RumourRevealRoll", client, revealChance, revealMath)
        for _, target in player.Iterator() do
            local targetFaction = lia.faction.indices[target:Team()]
            if targetFaction and targetFaction.criminal then
                ClientAddText(target, L("rumourMessagePrefix", rumourMessage))
            elseif revealMath and targetFaction and targetFaction.police then
                ClientAddText(target, L("rumourMessagePrefix", rumourMessage))
            end
        end

        if revealMath then hook.Run("RumourRevealed", client) end
        hook.Run("RumourSent", client, rumourMessage, revealMath)
    end
})
