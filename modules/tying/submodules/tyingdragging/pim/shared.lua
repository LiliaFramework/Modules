PIM:AddOption("Drag Player", {
    runServer = true,
    shouldShow = function(client, target) return IsHandcuffed(target) and not IsDraggingPlayer(client, target) end,
    onRun = function(client, target)
        if not SERVER then return end
        SetDrag(target, client, true)
    end
})

PIM:AddOption("Stop Dragging", {
    runServer = true,
    shouldShow = function(client, target) return IsDraggingPlayer(client, target) end,
    onRun = function(client, target)
        if not SERVER then return end
        SetDrag(target, client, false)
    end
})
