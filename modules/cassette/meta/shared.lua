
local entityMeta = FindMetaTable("Entity")

function entityMeta:isCassete()
    local class = self:GetClass()
    return class == "lia_cassetteplayer"
end

