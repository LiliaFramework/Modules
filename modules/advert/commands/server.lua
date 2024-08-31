local MODULE = MODULE

lia.command.add("advertisement", {
    adminOnly = false,
    syntax = "<string factions> <string text>",
    onRun = function(client, arguments)
        if not arguments[1] then return "Invalid argument (#1)" end
        local message = table.concat(arguments, " ", 1)
        if not client.advertdelay then client.advertdelay = 0 end
        if CurTime() < client.advertdelay then
            local seconds = math.ceil(client.advertdelay - CurTime())
            client:notifyLocalized("commandCooldownTimed", seconds)
            return
        end

        if client:getChar():hasMoney(MODULE.AdvertPrice) then
            client.advertdelay = CurTime() + MODULE.AdvertCooldown
            client:getChar():takeMoney(MODULE.AdvertPrice)
            client:notifyLocalized("AdvertDeductedMessage", MODULE.AdvertPrice, lia.currency.plural)
            net.Start("AdvertiseMessageCall")
            net.WriteString(client:Nick())
            net.WriteString(message)
            net.Broadcast()
        else
            client:notifyLocalized("AdvertInsufficientFunds")
        end
    end
})