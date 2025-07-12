local MODULE = MODULE
net.Receive("searchExit", function(_, client)
    MODULE:stopSearching(client)
end)
