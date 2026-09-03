local MODULE = MODULE
lia.command.add("partytier", {
    adminOnly = true,
    arguments = {
        {
            name = "target",
            type = "player"
        },
        {
            name = "tier",
            type = "number"
        }
    },
    desc = "partytierCommandDesc",
    AdminStick = {
        Name = "partytierCommandDesc",
        Category = "loyalism"
    },
    onRun = function(client, arguments)
        local char = client:getChar()
        if not char then return "You must be on your character to do that." end
        local target = lia.util.findPlayer(client, arguments[1])
        if not char:hasFlags("T") then
            client:notify("noPerm")
            return
        end

        if not target or not IsValid(target) then
            client:notify("Target not found.")
            return
        end

        local tierArg = arguments[2]
        if not tierArg or tonumber(tierArg) == nil then
            client:notify("Invalid party tier.")
            return
        end

        local tier = tonumber(tierArg)
        if tier > #MODULE.Tiers then tier = 10 end
        local tChar = target:getChar()
        if tChar then
            tChar:setPartyTier(tier)
            client:notify(string.format("%s's loyalty tier is now %s.", target:Name(), tier))
            if tier == 0 then
                target:notify(string.format("Your loyalty tier has been cleared by %s.", client:Name()))
            else
                target:notify(string.format("Your loyalty tier is now %s.", tier))
            end
        end

        MODULE:UpdatePartyTiers()
    end
})
