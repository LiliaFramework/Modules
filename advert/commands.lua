lia.command.add("advertisement", {
    alias = "advert",
    adminOnly = false,
    arguments = {
        {
            name = "message",
            type = "string"
        }
    },
    desc = "advertCommandDesc",
    onRun = function(client, arguments)
        if not arguments[1] then return L("invalidArg") end
        local message = table.concat(arguments, " ", 1)
        if not client.advertdelay then client.advertdelay = 0 end
        if CurTime() < client.advertdelay then
            local seconds = math.ceil(client.advertdelay - CurTime())
            client:notifyLocalized("advertCommandCooldownTimed", seconds)
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

            lia.log.add(client, "advert", message)
            hook.Run("AdvertSent", client, message)
        else
            client:notifyLocalized("AdvertInsufficientFunds")
        end
    end,
})
