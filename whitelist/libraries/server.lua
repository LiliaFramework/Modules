function MODULE:CheckPassword( steamID64 )
	local whitelistEnabled = lia.config.get( "WhitelistEnabled" )
	local blacklistEnabled = lia.config.get( "BlacklistedEnabled" )
	if blacklistEnabled and table.HasValue( self.BlacklistedSteamID64, steamID64 ) then return false, "You are blacklisted from this server!" end
	if whitelistEnabled and not table.HasValue( self.WhitelistedSteamID64, steamID64 ) then return false, "Sorry, you are not whitelisted for " .. GetHostName() end
end
