local playerMeta = FindMetaTable("Player")
function playerMeta:getAdditionalCharSlots()
    return self:getLiliaData("AdditionalCharSlots", 0)
end

if SERVER then
    function playerMeta:setAdditionalCharSlots(val)
        self:setLiliaData("AdditionalCharSlots", val)
        self:saveLiliaData()
    end

    function playerMeta:giveAdditionalCharSlots(AddValue)
        AddValue = math.max(0, AddValue or 1)
        self:setAdditionalCharSlots(self:getAdditionalCharSlots() + AddValue)
    end
end
