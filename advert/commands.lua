local realName = false
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
        if not arguments[1] then return "invalidArg" end
        local message = table.concat(arguments, " ", 1)
        if not client.advertdelay then client.advertdelay = 0 end
        if CurTime() < client.advertdelay then
            local seconds = math.ceil(client.advertdelay - CurTime())
            client:notify(string.format("Please wait %s seconds before advertising again.", seconds))
            return
        end

        local advertPrice = lia.config.get("AdvertPrice", 10)
        local advertCooldown = lia.config.get("AdvertCooldown", 20)
        if client:getChar():hasMoney(advertPrice) then
            client.advertdelay = CurTime() + advertCooldown
            client:getChar():takeMoney(advertPrice)
            client:notify(string.format("You paid %s%s for your advertisement.", advertPrice, lia.currency.plural))
            if not SERVER then return end
            for _, ply in player.Iterator() do
                local displayedName = realName and client:Name() or client:getChar():getDisplayedName(ply)
                lia.util.addText(ply, Color(216, 190, 18), string.format("[ADVERT] %s:", displayedName), Color(255, 255, 255), message)
            end
        else
            client:notify("You don't have enough money to advertise.")
        end
    end,
})
