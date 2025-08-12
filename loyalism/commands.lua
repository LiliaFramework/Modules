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
        Category = "moderationTools",
        SubCategory = "partyTiers"
    },
    onRun = function(client, arguments)
        local char = client:getChar()
        if not char then return L("mustBeOnCharacter") end
        local target = lia.util.findPlayer(client, arguments[1])
        if not char:hasFlags("T") then
            client:notifyLocalized("noPerm")
            return
        end

        if not target or not IsValid(target) then
            client:notifyLocalized("targetNotFound")
            return
        end

        local tierArg = arguments[2]
        if not tierArg or tonumber(tierArg) == nil then
            client:notifyLocalized("invalidPartyTier")
            return
        end

        local tier = tonumber(tierArg)
        if tier > #MODULE.Tiers then tier = 10 end
        local tChar = target:getChar()
        if tChar then
            tChar:setPartyTier(tier)
            client:notifyLocalized("partyTierUpdated", target:Name(), tier)
            if tier == 0 then
                target:notifyLocalized("partyTierRemoved", client:Name())
            else
                target:notifyLocalized("partyTierSet", tier)
            end
        end

        MODULE:UpdatePartyTiers()
    end
})