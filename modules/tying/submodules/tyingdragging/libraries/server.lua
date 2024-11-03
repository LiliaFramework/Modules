function MODULE:PlayerDisconnected(dragee)
    local drager = dragee:GetNWEntity("dragpair")
    if not IsValid(drager) then return end
    if not drager:GetNWBool("dragging", false) then return end
    if not dragee:GetNWBool("dragged", false) then return end
    SetDrag(dragee, drager, false)
end

function MODULE:PlayerDeath(dragee)
    local drager = dragee:GetNWEntity("dragpair")
    SetDrag(dragee, drager, false)
end

function SetDrag(dragee, drager, bool)
    if not IsValid(dragee) then return end
    if bool then
        dragee:SetNWBool("dragged", true)
        dragee:SetNWEntity("dragpair", drager)
        if IsValid(drager) then
            drager:SetNWBool("dragging", true)
            drager:SetNWEntity("dragpair", dragee)
        end
    else
        dragee:SetNWEntity("dragpair")
        dragee:SetNWBool("dragged", false)
        if IsValid(drager) then
            drager:SetNWBool("dragging", false)
            drager:SetNWEntity("dragpair")
        end
    end
end

function MODULE:ResetSubModuleCuffData(dragee)
    local drager = dragee:GetNWEntity("dragpair")
    SetDrag(dragee, drager, false)
end
