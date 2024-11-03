function IsDragged(target)
    return target:GetNWBool("dragged", false)
end

function IsDraggingSomeone(target)
    return target:GetNWBool("dragging", false)
end

function IsDraggingPlayer(target)
    return target:GetNWBool("dragging", false)
end

function GetDragger(target)
    local dragger = target:GetNWEntity("dragpair")
    if not IsDraggingSomeone(dragger) then return end
    return dragger
end

function GetDragee(target)
    local dragee = target:GetNWEntity("dragpair")
    if not IsDragged(dragee) then return end
    return dragee
end
