function MODULE:PlayerSwitchFlashlight(client, isEnabled)
    if not client:getChar() then return false end
    local flashlightEnabled = lia.config.get("FlashlightEnabled", true)
    local flashlightNeedsItem = lia.config.get("FlashlightNeedsItem", true)
    local flashlightCooldown = lia.config.get("FlashlightCooldown", 0.5)
    local itemNeeded = self.FlashlightItems
    local hasFlashlight = false
    if flashlightEnabled and (client.FlashlightCooldown or 0) < CurTime() then
        if flashlightNeedsItem then
            if istable(itemNeeded) then
                for _, item in ipairs(itemNeeded) do
                    if client:getChar():getInv():hasItem(item) then
                        hasFlashlight = true
                        break
                    end
                end
            else
                if client:getChar():getInv():hasItem(itemNeeded) then hasFlashlight = true end
            end
        else
            hasFlashlight = true
        end

        if hasFlashlight then
            client:EmitSound(isEnabled and "buttons/button24.wav" or "buttons/button10.wav", 60, isEnabled and 100 or 70)
            client.FlashlightCooldown = CurTime() + flashlightCooldown
            client:ConCommand("r_shadows " .. (isEnabled and "1" or "0"))
            return true
        end
    end
    return false
end
