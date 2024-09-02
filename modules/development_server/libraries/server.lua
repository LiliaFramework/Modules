function MODULE:CheckPassword(steamid64)
    if not table.HasValue(self.AuthorizedDevelopers, steamid64) and self.DevServer then return false, L("devServerUnauthorized") end
end