local MODULE = MODULE
lia.playerinteract.addInteraction("requestSearch", {
    serverOnly = true,
    shouldShow = function(client, target) return not target.SearchRequested and not client.SearchRequested and not target:isBeingSearched() end,
    onRun = function(client, target)
        if not SERVER then return end
        client:notifyLocalized("requestSearchSent")
        target.SearchRequested = client
        client.SearchRequested = target
        target:binaryQuestion(L("requestSearchInventory"), L("accept"), L("deny"), false, function(choice)
            if choice == 0 then
                MODULE:searchPlayer(client, target)
            else
                client:notifyLocalized("searchDenied")
            end

            client.SearchRequested = nil
            target.SearchRequested = nil
        end)
    end
})

lia.playerinteract.addInteraction("search", {
    serverOnly = true,
    shouldShow = function(_, target) return target:isHandcuffed() and not target:isBeingSearched() end,
    onRun = function(client, target)
        if not SERVER then return end
        MODULE:searchPlayer(client, target)
    end
})
