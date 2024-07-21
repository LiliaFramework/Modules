util.AddNetworkString("cOpen")

netstream.Hook("cPlayerActive", function(client, entity)
    local distance = client:GetPos():Distance(entity:GetPos())
    if entity:IsValid() and client:IsValid() and client:getChar() and distance < 128 then entity:activate() end
end)

netstream.Hook("cPlayerDisable", function(client, entity)
    local distance = client:GetPos():Distance(entity:GetPos())
    if entity:IsValid() and client:IsValid() and client:getChar() and distance < 128 then entity:disable() end
end)
