function MODULE:PlayerSwitchFlashlight(client, isEnabled)
    if not client:getChar() then return false end
    local flashlightEnabled = lia.config.get("FlashlightEnabled", true)
    local flashlightNeedsItem = lia.config.get("FlashlightNeedsItem", true)
    local flashlightCooldown = lia.config.get("FlashlightCooldown", 0.5)
    if not flashlightEnabled then return false end
    if (client.FlashlightCooldown or 0) >= CurTime() then return false end
    local hasFlashlight = false
    if flashlightNeedsItem then
        for _, item in pairs(client:getChar():getInv():getItems()) do
            if item.isFlashlight then
                hasFlashlight = true
                break
            end
        end

        if not hasFlashlight then return false end
    else
        hasFlashlight = true
    end

    client:EmitSound(isEnabled and "buttons/button24.wav" or "buttons/button10.wav", 60, isEnabled and 100 or 70)
    client.FlashlightCooldown = CurTime() + flashlightCooldown
    client:ConCommand("r_shadows " .. (isEnabled and "1" or "0"))
    return true
end