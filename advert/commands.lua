lia.command.add("advertisement", {
    alias = "advert",
    adminOnly = false,
    syntax = "[string message]",
    desc = "Broadcasts a paid advertisement to all players, charging you money and applying a cooldown.",
    onRun = function(client, arguments)
        if not arguments[1] then return "Invalid argument (#1)" end
        local message = table.concat(arguments, " ", 1)
        if not client.advertdelay then client.advertdelay = 0 end
        if CurTime() < client.advertdelay then
            local seconds = math.ceil(client.advertdelay - CurTime())
            client:notifyLocalized("commandCooldownTimed", seconds)
            return
        end

        local advertPrice = lia.config.get("AdvertPrice", 10)
        local advertCooldown = lia.config.get("AdvertCooldown", 20)
        if client:getChar():hasMoney(advertPrice) then
            client.advertdelay = CurTime() + advertCooldown
            client:getChar():takeMoney(advertPrice)
            client:notifyLocalized("AdvertDeductedMessage", advertPrice, lia.currency.plural)
            if not SERVER then return end
            for _, ply in player.Iterator() do
                local displayedName = client:getChar():getDisplayedName(ply)
                ClientAddText(ply, Color(216, 190, 18), L("AdvertFormat", displayedName), Color(255, 255, 255), message)
            end
        else
            client:notifyLocalized("AdvertInsufficientFunds")
        end
    end,
})
