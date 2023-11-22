------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
lia.command.add(
    "refunddeath",
    {
        privilege = "Refund Death Money",
        syntax = "[string player]",
        adminOnly = true,
        onRun = function(client, arguments)
            if not arguments[1] then
                client:notify("Please provide player", NOT_ERROR)
                return
            end

            local target = lia.command.findPlayer(client, arguments[1])
            if not target then
                client:notify("Player not found!", NOT_ERROR)
                return
            end

            local previousTake = target:getNetVar("previousDeathTake")
            if previousTake then
                target:getChar():giveMoney(previousTake)
                target:setNetVar("previousDeathTake", nil)
                local s = "You restored %s for %s"
                s = string.format(s, lia.currency.get(previousTake), target:Nick())
                client:notify(s)
            else
                client:notify("Player doesn't have a previous death penalty.", NOT_ERROR)
            end
        end
    }
)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------