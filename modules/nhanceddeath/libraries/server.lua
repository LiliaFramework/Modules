function MODULE:PlayerSpawn(client)
    if not client:getChar() then return end
    if client:getNetVar("hospitalDeath", false) then
        local respawnLocation = table.Random(self.HospitalLocations)
        timer.Simple(0, function()
            client:Spawn()
            client:SetPos(respawnLocation)
            client:setNetVar("hospitalDeath", false)
            if self.LoseMoneyOnDeath then
                local currentMoney = client:getChar():getMoney()
                local moneyLoss = math.ceil(currentMoney * self.DeathMoneyLoss)
                if moneyLoss > currentMoney then moneyLoss = currentMoney end
                client:getChar():takeMoney(moneyLoss)
                client:notify("You lost " .. lia.currency.get .. " " .. moneyLoss .. " on death.")
            end
        end)
    end
end

function MODULE:PlayerDeath(client)
    if not (client:getChar() or self.HospitalsEnabled) then return end
    client:setNetVar("hospitalDeath", true)
end
