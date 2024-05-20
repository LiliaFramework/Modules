local playerMeta = FindMetaTable("Player")
function playerMeta:ToggleWanted()
    self:setNetVar("wanted", self:IsWanted() and false or true)
end
