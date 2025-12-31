local MODULE = MODULE
function MODULE:OnNPCKilled(npc, attacker)
    if not IsValid(attacker) or not attacker:IsPlayer() then return end
    local npcClass = npc:GetClass()
    local moneyAmount = self.MoneyTable[npcClass] or self.MoneyTable["default"] or 0
    if moneyAmount > 0 then
        attacker:addMoney(moneyAmount)
        attacker:notifyMoney("You received $" .. moneyAmount .. " from killing the " .. npcClass:gsub("npc_", ""):gsub("_", " ") .. "!")
    end
end
