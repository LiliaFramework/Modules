-------------------------------------------------------------------------------------------------------------
function MODULE:PlayerSwitchFlashlight(client, enabled)
    if lia.config.FlashlightEnabled and lia.config.FlashlightItemRequired ~= nil and client:getChar():getInv():hasItem(lia.config.FlashlightItemRequired) then return true end
    return false
end
-------------------------------------------------------------------------------------------------------------
