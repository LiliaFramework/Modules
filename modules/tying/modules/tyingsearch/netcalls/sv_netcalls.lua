----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local MODULE = MODULE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
netstream.Hook(
    "searchExit",
    function(client)
        MODULE:stopSearching(client)
    end
)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
net.Receive(
    "ApproveSearch",
    function(len, ply)
        local requester = ply.SearchRequested
        if not requester then return end
        if not requester.SearchRequested then return end
        local approveSearch = net.ReadBool()
        if not approveSearch then
            requester:notify("Player denied your request to view their inventory.")
            requester.SearchRequested = nil
            ply.SearchRequested = nil

            return
        end

        if requester:GetPos():DistToSqr(ply:GetPos()) > 250 * 250 then return end
        MODULE:searchPlayer(requester, ply, true)
        requester.SearchRequested = nil
        ply.SearchRequested = nil
    end
)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------