local entityMeta = FindMetaTable("Entity")
local chairCache
local function buildChairCache()
    chairCache = {}
    for _, vehicleData in pairs(list.Get("Vehicles")) do
        if vehicleData.Category == "Chairs" and isstring(vehicleData.Model) then
            chairCache[vehicleData.Model] = true
            chairCache[vehicleData.Model:lower()] = true
        end
    end
end

function entityMeta:isChair()
    if not chairCache then buildChairCache() end
    if not IsValid(self) then return false end
    local model = self:GetModel()
    if not isstring(model) or model == "" then return false end
    return chairCache[model] or chairCache[model:lower()] or false
end
