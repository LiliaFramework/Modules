local MODULE = MODULE
function MODULE:OnPlayerObserve(client)
    if client.rappelling then self:EndRappel(client) end
end
