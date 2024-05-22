function MODULE:WarnPlayer(client, target, reason)
    local tChar = target:getChar()
    local warnCount = tChar:getData("warn", 0)
    tChar:setData("warn", warnCount + 1)
    target:GodEnable()
    target:Freeze(true)
    target:ChatPrint("You received a warning from " .. client:GetName() .. " Reason: " .. reason .. ". Your new total is " .. warnCount .. ".")
    target:notify("You were frozen for " .. self.FreezeTime .. " seconds. Please read the warning!")
    timer.Simple(self.FreezeTime, function()
        if IsValid(target) then
            target:GodDisable()
            target:Freeze(false)
            if warnCount >= self.WarnsTillBan then
                target:notify("Your character has been blocked for exceeding the allowed number of warnings!")
                timer.Simple(5, function() tChar:ban(self.BanTime) end)
            end
        end
    end)
end

lia.log.addType("playerWarned", function(client, tChar, reason)
    local tCharName = tChar:getName()
    return string.format("%s was warned by %s. Reason: %s", tCharName, client:Name(), reason)
end)
