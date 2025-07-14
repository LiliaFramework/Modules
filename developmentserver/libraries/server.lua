function MODULE:CheckPassword(steamid64)
    if lia.config.get("DevServer", false) and not table.HasValue(self.AuthorizedDevelopers, steamid64) then
        hook.Run("DevServerUnauthorized", steamid64)
        return false, L("devServerUnauthorized")
    else
        hook.Run("DevServerAuthorized", steamid64)
    end
end

function MODULE:InitializedModules()
    if lia.config.get("DevServer", false) then
        lia.information(L("devServerActive"))
        hook.Run("DevServerModeActivated")
    else
        hook.Run("DevServerModeDeactivated")
    end
end
