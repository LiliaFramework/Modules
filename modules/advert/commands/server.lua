local MODULE = MODULE

lia.command.add("advertisement", {
    adminOnly = false,
    syntax = "<string factions> <string text>",
    onRun = function(client, arguments)
        if not arguments[1] then return "Invalid argument (#1)" end
        
        local message = table.concat(arguments, " ", 1)
        
        if not client.advertdelay then client.advertdelay = 0 end
        
        if CurTime() < client.advertdelay then
            local timeLeft = math.ceil(client.advertdelay - CurTime())
            client:notify("This command is on cooldown! Time remaining: " .. timeLeft .. " seconds.")
            return
        end
        
        if client:getChar():hasMoney(MODULE.AdvertPrice) then
            client.advertdelay = CurTime() + MODULE.AdvertCooldown
            client:getChar():takeMoney(MODULE.AdvertPrice)
            client:notify(MODULE.AdvertPrice .. " " .. lia.currency.plural .. " have been deducted from your wallet for advertising.")
            
            net.Start("AdvertiseMessageCall")
            net.WriteString(client:Nick())
            net.WriteString(message)
            net.Broadcast()
        else
            client:notify("You lack sufficient funds to make an advertisement.")
        end
    end
})