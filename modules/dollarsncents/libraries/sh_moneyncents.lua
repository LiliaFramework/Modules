-------------------------------------------------------------------------------------------
hook.Add(
    "InitializedModules",
    "_moneytocents",
    function()
        local GM = GM or Gamemode or gamemode or {}
        function GM:OnPickupMoney(client, moneyEntity)
            if moneyEntity and moneyEntity:IsValid() then
                local amount = moneyEntity:getAmount()
                client:getChar():giveMoney(amount)
                client:notifyLocalized("moneyTaken", lia.currency.get(amount / 100))
            end
        end

        lia.command.list.charsetmoney.onRun = function(client, arguments)
            local amount = tonumber(arguments[2])
            if not amount or not isnumber(amount) or amount < 0 then return "@invalidArg", 2 end
            local target = lia.command.findPlayer(client, arguments[1])
            if IsValid(target) then
                local char = target:getChar()
                if char and amount then
                    amount = math.Round(amount * 100)
                    char:setMoney(amount)
                    client:notifyLocalized("setMoney", target:Name(), lia.currency.get(amount / 100))
                end
            end

            lia.command.list.givemoney.onRun = function(client, arguments)
                local number = tonumber(arguments[1])
                number = number or 0
                local amount = math.floor(number)
                if not amount or not isnumber(amount) or amount <= 0 then return L("invalidArg", client, 1) end
                local data = {}
                data.start = client:GetShootPos()
                data.endpos = data.start + client:GetAimVector() * 96
                data.filter = client
                local target = util.TraceLine(data).Entity
                if IsValid(target) and target:IsPlayer() and target:getChar() then
                    amount = math.Round(amount * 100)
                    if not client:getChar():hasMoney(amount) then return end
                    target:getChar():giveMoney(amount)
                    client:getChar():takeMoney(amount)
                    target:notifyLocalized("moneyTaken", lia.currency.get(amount))
                    client:notifyLocalized("moneyGiven", lia.currency.get(amount))
                end
            end
        end
    end
)

-------------------------------------------------------------------------------------------
hook.Add(
    "InitPostEntity",
    "over_inject_money",
    function()
        print("Injecting Overwrite Decimal Feature")
        local ENT = scripted_ents.GetStored("lia_money").t
        if CLIENT then
            local toScreen = FindMetaTable("Vector").ToScreen
            local colorAlpha = ColorAlpha
            local drawText = lia.util.drawText
            function ENT:onDrawEntityInfo(alpha)
                local position = toScreen(self:LocalToWorld(self:OBBCenter()))
                local x, y = position.x, position.y
                drawText(lia.currency.get(self:getAmount() / 100), x, y, colorAlpha(lia.config.Color, alpha), 1, 1, nil, alpha * 0.65)
            end

            local charMeta = lia.meta.character
            function charMeta:getMoney()
                return self.vars.money / 100
            end
        end
    end
)
-------------------------------------------------------------------------------------------
