local blacklist = {"nigger", "faggot", "chink", "kike", "spic", "gook", "wetback", "dyke", "tranny", "retard", "coon", "raghead", "nip", "honky", "gyp", "beaner", "paki", "slant", "slope", "jap"}
function MODULE:PlayerSay(ply, text)
    local lowerText = text:lower()
    for _, bad in pairs(blacklist) do
        if lowerText:find(bad, 1, true) then
            ply:notifyLocalized("usedFilteredWord")
            return ""
        end
    end
end