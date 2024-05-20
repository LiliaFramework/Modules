local MODULE = MODULE
lia.command.add("partytier", {
    adminOnly = true,
    privilege = "Management - Assign Party Tiers",
    syntax = "<string name> <string number>",
    onRun = function(client, arguments)
        local char = client:getChar()
        if not char then return "You must be on a character to use this" end
        local target = lia.command.findPlayer(client, arguments[1])
        if not char:hasFlags("T") then
            client:notify("You don't have permissions for that.")
            return
        end

        local tier = arguments[2]
        if tonumber(tier) > #MODULE.Tiers then tier = 10 end
        local tChar = target:getChar()
        if tChar then
            tChar:setData("party_tier", tier, false, player.GetAll())
            client:notify("You have updated " .. target:Name() .. "'s Party Tier " .. tier .. " .")
            if tier == 0 then
                target:notify(client:Name() .. " has removed your Party Tier!")
            else
                target:notify("You have been set as Party Tier " .. tier .. " .")
            end
        end

        MODULE:UpdatePartyTiers()
    end
})
