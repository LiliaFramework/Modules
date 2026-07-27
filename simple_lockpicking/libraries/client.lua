function MODULE:DrawCharInfo(client, _, info)
    if client:getNetVar("isPicking") then
        info[#info + 1] = {
            section = "Activity"
        }

        info[#info + 1] = {
            label = "Action",
            value = "Lockpicking"
        }
    end
end

function MODULE:PlayerBindPress(ply, bind)
    if string.find(bind, "+use") and ply:getNetVar("isPicking") or string.find(bind, "+attack" or string.find(bind, "+attack2") and ply:getNetVar("isPicking")) and ply:getNetVar("isPicking") then return true end
end
