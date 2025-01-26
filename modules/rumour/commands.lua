local MODULE = MODULE
local AllowedFactions = {FACTION_STAFF}
lia.command.add("rumour", {
    adminOnly = false,
    syntax = "<string message>",
    onRun = function(client, arguments)
        if not table.HasValue(AllowedFactions, client:Team()) then
            client:ChatPrint(L("rumourNotAllowed"))
            return
        end

        local rumourMessage = table.concat(arguments, " ")
        if rumourMessage == "" then
            client:ChatPrint(L("rumourNoMessage"))
            return
        end

        if not client.rumourdelay then client.rumourdelay = 0 end
        if CurTime() < client.rumourdelay then
            local seconds = math.ceil(client.rumourdelay - CurTime())
            client:notifyLocalized("commandCooldownTimed", seconds)
            return
        else
            client.rumourdelay = CurTime() + lia.config.get("RumourCooldown", 60)
            for _, target in player.Iterator() do
                if table.HasValue(AllowedFactions, target:Team()) then
                    net.Start("RumorMessageCall")
                    net.WriteString(rumourMessage)
                    net.Send(target)
                end
            end
        end
    end
})
