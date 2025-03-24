function MODULE:PlayerDeath( client )
	if client:IsWanted() and lia.config.get( "RemoveWarrantOnDeath" ) then client:ToggleWanted() end
end
