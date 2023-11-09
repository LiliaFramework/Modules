----------------------------------------------------------------------------------------------
hook.Add(
    "VC_canAfford",
    "Fix_Has",
    function(ply, amount)
        if ply:getChar():hasMoney(amount) then
            return true
        else
            return false
        end
    end
)
----------------------------------------------------------------------------------------------
hook.Add(
    "VC_canAddMoney",
    "Fix_Give",
    function(ply, amount)
        ply:getChar():giveMoney(amount)
        local can = false
        return can
    end
)
----------------------------------------------------------------------------------------------
hook.Add(
    "VC_canRemoveMoney",
    "Fix_Take",
    function(ply, amount)
        ply:getChar():takeMoney(amount)
        local can = false
        return can
    end
)
----------------------------------------------------------------------------------------------