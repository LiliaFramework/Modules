local playerMeta = FindMetaTable("Player")
function playerMeta:ResetBAC()
    self:SetNW2Int("lia_alcoholism_bac", 0)
end

function playerMeta:AddBAC(amt)
    if not amt or not isnumber(amt) then return end
    self:SetNW2Int("lia_alcoholism_bac", math.Clamp(self:GetNW2Int("lia_alcoholism_bac", 0) + amt, 0, 100))
end
