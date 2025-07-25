﻿local MODULE = MODULE
AddInteraction(L("requestSearch"), {
    runServer = true,
    shouldShow = function(client, target) return not target.SearchRequested and not client.SearchRequested and not target:IsBeingSearched() end,
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

AddInteraction(L("search"), {
    runServer = true,
    shouldShow = function(_, target) return target:IsHandcuffed() and not target:IsBeingSearched() end,
    onRun = function(client, target)
        if not SERVER then return end
        MODULE:searchPlayer(client, target)
    end
})
