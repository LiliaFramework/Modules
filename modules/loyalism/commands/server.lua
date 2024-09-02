local MODULE = MODULE

lia.command.add("partytier", {
    adminOnly = true,
    privilege = "Management - Assign Party Tiers",
    syntax = "<string name> <string number>",
    onRun = function(client, arguments)
        local char = client:getChar()
        if not char then return L("mustBeOnCharacter") end
        local target = lia.command.findPlayer(client, arguments[1])
        if not char:hasFlags("T") then
            client:notifyLocalized("noPerm")
            return
        end

        local tier = arguments[2]
        if tonumber(tier) > #MODULE.Tiers then tier = 10 end
        local tChar = target:getChar()
        if tChar then
            tChar:setData("party_tier", tier, false, player.GetAll())
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