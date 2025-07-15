function MODULE:CheckPassword(steamID64)
    hook.Run("PreWhitelistCheck", steamID64)
    local whitelistEnabled = lia.config.get("WhitelistEnabled")
    local blacklistEnabled = lia.config.get("BlacklistedEnabled")
    if blacklistEnabled and table.HasValue(self.BlacklistedSteamID64, steamID64) then
        hook.Run("PlayerBlacklisted", steamID64)
        hook.Run("PostWhitelistCheck", steamID64, false)
        return false, L("blacklistKick")
    end

    if whitelistEnabled and not table.HasValue(self.WhitelistedSteamID64, steamID64) then
        hook.Run("PlayerNotWhitelisted", steamID64)
        hook.Run("PostWhitelistCheck", steamID64, false)
        return false, L("whitelistKick", GetHostName())
    end

    hook.Run("PlayerWhitelisted", steamID64)
    hook.Run("PostWhitelistCheck", steamID64, true)
end
