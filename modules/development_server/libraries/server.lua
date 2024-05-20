
function MODULE:CheckPassword(steamid64, ipaddress, svPassword, clPassword, name)
    if not table.HasValue(self.AuthorizedDevelopers, steamid64) and self.DevServer then return false, "You are not authorized to join the server during development periods." end
end

