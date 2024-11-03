function MODULE:DrawCharInfo(client, character, info)
    if IsHandcuffed(client) and IsDragged(client) then info[#info + 1] = {"Being Dragged", Color(245, 215, 110)} end
    if IsDraggingSomeone(client) then info[#info + 1] = {"Draging Someone", Color(245, 215, 110)} end
end
