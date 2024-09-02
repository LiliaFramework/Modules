function MODULE:WarnPlayer(client, target, reason)
    local tChar = target:getChar()
    local warnCount = tChar:getData("warn", 0)
    tChar:setData("warn", warnCount + 1)
    target:GodEnable()
    target:Freeze(true)
    local chatMessage = L("warnPlayerReceived", client:GetName(), reason, warnCount + 1)
    target:ChatPrint(chatMessage)
    local notifyMessage = L("warnPlayerFrozen", self.FreezeTime)
    target:notify(notifyMessage)
    timer.Simple(self.FreezeTime, function()
        if IsValid(target) then
            target:GodDisable()
            target:Freeze(false)
            if warnCount >= self.WarnsTillBan then
                target:notify(L("warnPlayerBlocked"))
                timer.Simple(5, function() tChar:ban(self.BanTime) end)
            end
        end
    end)
end

lia.log.addType("playerWarned", function(client, tChar, reason)
    local tCharName = tChar:getName()
    return string.format("%s was warned by %s. Reason: %s", tCharName, client:Name(), reason)
end, "Warnings", Color(255, 0, 0), "Warnings")