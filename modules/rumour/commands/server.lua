local MODULE = MODULE

lia.command.add("rumour", {
    adminOnly = false,
    syntax = "<string message>",
    onRun = function(client, arguments)
        if not table.HasValue(MODULE.AllowedFactions, client:Team()) then
            client:ChatPrint("You are not allowed to use /rumour.")
            return
        end

        local rumourMessage = table.concat(arguments, " ")
        if rumourMessage == "" then
            client:ChatPrint("You must provide a message for /rumour.")
            return
        end

        if not client.rumourdelay then client.rumourdelay = 0 end
        if CurTime() < client.rumourdelay then
            local remainingTime = math.ceil(client.rumourdelay - CurTime())
            client:notify("This command is in cooldown! Time left: " .. remainingTime .. " seconds.")
            return
        else
            client.rumourdelay = CurTime() + MODULE.RumourCooldown
            for _, player in ipairs(player.GetAll()) do
                if table.HasValue(MODULE.AllowedFactions, player:Team()) then
                    net.Start("RumorMessageCall")
                    net.WriteString(rumourMessage)
                    net.Send(player)
                end
            end
        end
    end
})