net.Receive("radioAdjust", function(_, client)
    local freq = net.ReadString()
    local id = net.ReadUInt(32)
    if id == 0 then id = nil end
    local inv = client:getChar() and client:getChar():getInv() or nil
    if inv then
        local item
        if id then
            item = lia.item.instances[id]
        else
            item = inv:hasItem("radio")
        end

        local ent = item:getEntity()
        if item and (IsValid(ent) or item:getOwner() == client) then
            (ent or client):EmitSound("buttons/combine_button1.wav", 50, 170)
            item:setData("freq", freq, player.GetAll(), false, true)
        else
            client:notify("You don't have a radio.")
        end
    end
end)
