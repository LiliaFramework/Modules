function IsBlinded(target)
    if target:getNetVar("blinded", false) then return true end
    return false
end

function IsGagged(target)
    if target:getNetVar("gagged", false) then return true end
    return false
end
