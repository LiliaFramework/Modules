local MODULE = MODULE
PIM:AddOption("Request Search", {
    runServer = true,
    shouldShow = function(client, target) return not target.SearchRequested and not client.SearchRequested and not IsBeingSearched(target) end,
    onRun = function(client, target)
        if not SERVER then return end
        client:notify("Request to search sent.")
        target.SearchRequested = client
        client.SearchRequested = target
        client:binaryQuestion("requestSearchInventory", "accept", "deny", false, function(choice)
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

PIM:AddOption("Search", {
    runServer = true,
    shouldShow = function(_, target) return IsHandcuffed(target) and not IsBeingSearched(target) end,
    onRun = function(client, target)
        if not SERVER then return end
        MODULE:searchPlayer(client, target)
    end
})
