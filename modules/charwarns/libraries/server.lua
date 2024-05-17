------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CharacterWarns:WarnPlayer(client, target, reason)
    local tChar = target:getChar()
    local warnCount = tChar:getData("warn", 0)
    tChar:setData("warn", warnCount + 1)
    target:GodEnable()
    target:Freeze(true)
    target:ChatPrint("You received a warning from " .. client:GetName() .. " Reason: " .. reason .. ". Your new total is " .. warnCount .. ".")
    target:notify("You were frozen for " .. CharacterWarns.FreezeTime .. " seconds. Please read the warning!")
    timer.Simple(
        CharacterWarns.FreezeTime,
        function()
            if IsValid(target) then
                target:GodDisable()
                target:Freeze(false)
                if warnCount >= CharacterWarns.WarnsTillBan then
                    target:notify("Your character has been blocked for exceeding the allowed number of warnings!")
                    timer.Simple(5, function() tChar:ban(CharacterWarns.BanTime) end)
                end
            end
        end
    )
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------