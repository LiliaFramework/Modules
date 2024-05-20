ITEM.name = "Blueprint Base"
ITEM.model = "models/props_lab/clipboard.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.flag = "y"
ITEM.desc = "Crafting's basic."
function ITEM:getDesc()
    if not self.entity or not IsValid(self.entity) then
        local strong = [[Requirements:%s
Result:%s]]
        local reqString = ""
        for _, v in ipairs(self.requirements) do
            local item = lia.item.list[v[1]]
            if item then reqString = reqString .. Format("\n %s x %d", item.name, v[2]) end
        end

        local resString = ""
        for _, v in ipairs(self.result) do
            local item = lia.item.list[v[1]]
            if item then resString = resString .. Format("\n %s x %d", item.name, v[2]) end
        end
        return Format(strong, reqString, resString)
    else
        return "A Blueprint Detailing A Recipe For Something"
    end
end

function ITEM:onRegistered()
    if SERVER and (self.requirements and self.result) and not self.base then ErrorNoHalt(self.uniqueID .. " does not have proper craft data!") end
end
