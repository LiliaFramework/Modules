local MODULE = MODULE
function MODULE:OnPlayerObserve(client, state)
	if client.rappelling then self:EndRappel(client) end
end