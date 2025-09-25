function MODULE:CalcView(client, pos)
    if lia.gui.character and IsValid(lia.gui.character) then return end
    if client:getChar() and client.KickingInDoor then
        local origin = pos + client:GetAngles():Forward() * -10
        local angles = (pos - origin):Angle()
        local view = {
            ["origin"] = origin,
            ["angles"] = angles
        }
        return view
    end
end
