lia.command.add("rumour", {
    adminOnly = false,
    arguments = {
        {
            name = "message",
            type = "string"
        }
    },
    desc = "rumourCommandDesc",
    onRun = function(client, arguments)
        local faction = lia.faction.indices[client:Team()]
        if not faction or not faction.criminal then
            client:ChatPrint("Your faction can't spread rumours.")
            return
        end

        local rumourMessage = table.concat(arguments, " ")
        if rumourMessage == "" then
            client:ChatPrint("You didn't provide a rumour.")
            return
        end

        if not client.rumourdelay then client.rumourdelay = 0 end
        if CurTime() < client.rumourdelay then
            local seconds = math.ceil(client.rumourdelay - CurTime())
            client:notify(string.format("Please wait %s seconds before spreading another rumour.", seconds))
            return
        end

        client.rumourdelay = CurTime() + lia.config.get("RumourCooldown", 60)
        local revealChance = lia.config.get("RumourRevealChance", 0.02)
        local revealMath = math.random() < revealChance
        local prefixColor = Color(255, 0, 0)
        local messageColor = Color(255, 255, 255)
        for _, target in player.Iterator() do
            local targetFaction = lia.faction.indices[target:Team()]
            if targetFaction and targetFaction.criminal then
                lia.util.addText(target, prefixColor, "[RUMOUR] ", messageColor, rumourMessage)
            elseif revealMath and targetFaction and targetFaction.police then
                lia.util.addText(target, prefixColor, "[RUMOUR] ", messageColor, rumourMessage)
            end
        end
    end
})
