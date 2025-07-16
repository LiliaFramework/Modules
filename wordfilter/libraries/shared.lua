local blacklist = {
    "nigger",
    "faggot",
    "chink",
    "kike",
    "spic",
    "gook",
    "wetback",
    "dyke",
    "tranny",
    "retard",
    "coon",
    "raghead",
    "nip",
    "honky",
    "gyp",
    "beaner",
    "paki",
    "slant",
    "slope",
    "jap"
}

function MODULE:LoadData()
    local stored = self:getData({})
    if istable(stored) then
        for _, word in ipairs(stored) do
            if not table.HasValue(blacklist, word) then
                table.insert(blacklist, word)
            end
        end
    end
end

function MODULE:SaveData()
    self:setData(blacklist)
end

function MODULE:AddBlacklistedWord(word)
    if not word then return end
    if table.HasValue(blacklist, word) then return end
    table.insert(blacklist, word)
    self:SaveData()
    hook.Run("WordAddedToFilter", word)
end

function MODULE:RemoveBlacklistedWord(word)
    if not word then return end
    for i, v in ipairs(blacklist) do
        if v == word then
            table.remove(blacklist, i)
            self:SaveData()
            hook.Run("WordRemovedFromFilter", word)
            break
        end
    end
end
function MODULE:PlayerSay(ply, text)
    hook.Run("PreFilterCheck", ply, text)
    local lowerText = text:lower()
    for _, bad in pairs(blacklist) do
        if lowerText:find(bad, 1, true) then
            hook.Run("FilteredWordUsed", ply, bad, text)
            hook.Run("PostFilterCheck", ply, text, false)
            hook.Run("FilterCheckFailed", ply, text, bad)
            ply:notifyLocalized("usedFilteredWord")
            return ""
        end
    end

    hook.Run("PostFilterCheck", ply, text, true)
    hook.Run("FilterCheckPassed", ply, text)
end
