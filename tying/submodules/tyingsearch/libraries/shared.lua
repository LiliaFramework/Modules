local playerMeta = FindMetaTable("Player")
function playerMeta:IsBeingSearched()
    return self:getNetVar("searcher")
end