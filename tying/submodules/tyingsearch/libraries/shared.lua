local playerMeta = FindMetaTable("Player")
function playerMeta:isBeingSearched()
    return self:getNetVar("searcher")
end
