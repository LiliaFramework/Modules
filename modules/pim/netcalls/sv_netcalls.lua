----------------------------------------------------------------------------------------------
netstream.Hook(
    "transferMoneyFromP2P",
    function(ply, amount, target)
        if amount < 0 then return end
        if not ply:getChar():hasMoney(amount) then return end
        target:getChar():giveMoney(amount)
        ply:getChar():takeMoney(amount)
        ply:notify("You transfered " .. lia.currency.symbol .. amount .. " to " .. target:Nick(), NOT_CORRECT)
        target:notify("You received " .. lia.currency.symbol .. amount .. " from " .. ply:Nick(), NOT_CORRECT)
    end
)

----------------------------------------------------------------------------------------------
netstream.Hook(
    "PIMRunOption",
    function(ply, name)
        local opt = PIM.options[name]
        if opt.runServer then opt.onRun(ply, ply:GetEyeTrace().Entity) end
    end
)
----------------------------------------------------------------------------------------------
