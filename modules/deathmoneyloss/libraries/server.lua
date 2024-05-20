function MODULE:PlayerDeath(client)
    local char = client:getChar()
    local money = char:getMoney()
    if money > 0 then
        local take = math.floor(money * self.DeathTake)
        char:takeMoney(take)
        client:setNetVar("previousDeathTake", take)
    end
end
