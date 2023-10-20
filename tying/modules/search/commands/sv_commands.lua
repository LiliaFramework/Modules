----------------------------------------------------------------------------------------------
local MODULE = MODULE
----------------------------------------------------------------------------------------------
lia.command.add(
    "stopsearch",
    {
        privilege = "Characters - Stop Searches",
        adminOnly = true,
        syntax = "<string player>",
        onRun = function(client, arguments)
            local target = lia.command.findPlayer(client, arguments[1])
            local searcher = target:getNetVar("searcher")
            if not target then return end
            if IsValid(searcher) then
                MODULE:stopSearching(searcher)
            end
        end
    }
)
----------------------------------------------------------------------------------------------
lia.command.add(
    "searchplayer",
    {
        privilege = "Characters - Search Players",
        adminOnly = true,
        syntax = "<string player>",
        onRun = function(client, arguments)
            local target = lia.command.findPlayer(client, arguments[1])
            if not target then return end
            MODULE:searchPlayer(client, target)
        end
    }
)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------