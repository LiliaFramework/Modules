function MODULE:PlayerSpawn(client)
    if not client:getChar() then return end
    if client:getNetVar("hospitalDeath", false) then
        local respawnLocation = table.Random(self.HospitalLocations or {})
        if respawnLocation then
            timer.Simple(0, function()
                if IsValid(client) then
                    client:SetPos(respawnLocation)
                    client:setNetVar("hospitalDeath", false)
                    if lia.config.get("LoseMoneyOnDeath", false) then
                        local currentMoney = client:getChar():getMoney()
                        local moneyLossPercentage = lia.config.get("DeathMoneyLoss", 0.05)
                        local moneyLoss = math.ceil(currentMoney * moneyLossPercentage)
                        if moneyLoss > 0 then
                            client:getChar():takeMoney(moneyLoss)
                            client:notify(L("moneyLossMessage", lia.currency.get(moneyLoss)))
                        end
                    end
                end
            end)
        end
    end
end

function MODULE:PlayerDeath(client)
    if not client:getChar() then return end
    if lia.config.get("HospitalsEnabled", false) then client:setNetVar("hospitalDeath", true) end
end
