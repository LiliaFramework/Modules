function MODULE:PlayerSwitchFlashlight(client, isEnabled)
    if not client:getChar() then return false end
    if hook.Run("PrePlayerToggleFlashlight", client, isEnabled) == false then return false end
    if hook.Run("CanPlayerToggleFlashlight", client, isEnabled) == false then return false end
    local enabled, needsItem, cooldown = lia.config.get("FlashlightEnabled", true), lia.config.get("FlashlightNeedsItem", true), lia.config.get("FlashlightCooldown", 0.5)
    if not enabled or (client.FlashlightCooldown or 0) >= CurTime() then return false end
    if needsItem then
        for _, item in pairs(client:getChar():getInv():getItems()) do
            if item.isFlashlight then
                client:EmitSound(isEnabled and "buttons/button24.wav" or "buttons/button10.wav", 60, isEnabled and 100 or 70)
                client.FlashlightCooldown = CurTime() + cooldown
                client:ConCommand("r_shadows " .. (isEnabled and "1" or "0"))
    hook.Run("PlayerToggleFlashlight", client, isEnabled)
                return true
            end
        end
        return false
    end

    client:EmitSound(isEnabled and "buttons/button24.wav" or "buttons/button10.wav", 60, isEnabled and 100 or 70)
    client.FlashlightCooldown = CurTime() + cooldown
    client:ConCommand("r_shadows " .. (isEnabled and "1" or "0"))
    hook.Run("PlayerToggleFlashlight", client, isEnabled)
    return true
end
