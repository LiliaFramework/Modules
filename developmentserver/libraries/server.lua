function MODULE:CheckPassword( steamid64 )
	if lia.config.get( "DevServer", false ) and not table.HasValue( self.AuthorizedDevelopers, steamid64 ) then return false, L( "devServerUnauthorized" ) end
end

function MODULE:InitializedModules()
	if lia.config.get( "DevServer", false ) then LiliaInformation( L( "devServerActive" ) ) end
end
