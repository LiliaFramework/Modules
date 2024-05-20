netstream.Hook("doCraft", function(client, entity)
    local distance = client:GetPos():DistToSqr(entity:GetPos())
    if entity:IsValid() and client:IsValid() and client:getChar() and distance < 16384 then entity:DoCraft(client) end
end)
