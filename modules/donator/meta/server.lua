
local playerMeta = FindMetaTable("Player")

function playerMeta:SetAdditionalCharSlots(val)
    self:setLiliaData("AdditionalCharSlots", val)
    self:saveLiliaData()
end


function playerMeta:GiveAdditionalCharSlots(AddValue)
    AddValue = math.max(0, AddValue or 1)
    self:SetAdditionalCharSlots(self:GetAdditionalCharSlots() + AddValue)
end

