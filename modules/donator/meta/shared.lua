
local playerMeta = FindMetaTable("Player")

function playerMeta:GetAdditionalCharSlots()
    return self:getLiliaData("AdditionalCharSlots", 0)
end

