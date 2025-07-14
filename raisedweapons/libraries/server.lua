function MODULE:PlayerSwitchWeapon(client, _, newWeapon)
    if IsValid(client) and IsValid(newWeapon) then
        local weaponClass = newWeapon:GetClass()
        if weaponClass ~= "lia_hands" and weaponClass ~= "lia_keys" then
            local raiseSpeed = lia.config.get("WeaponRaiseSpeed", 1)
            local speedOverride = hook.Run("OverrideWeaponRaiseSpeed", client, raiseSpeed)
            if speedOverride then raiseSpeed = speedOverride end
            hook.Run("WeaponRaiseScheduled", client, newWeapon, raiseSpeed)
            timer.Simple(raiseSpeed, function() if IsValid(client) then client:setWepRaised(true, false) end end)
        end
    end
end

function MODULE:KeyRelease(client, key)
    if key == IN_RELOAD then
        timer.Remove("WeaponHolstering" .. client:SteamID64())
        hook.Run("WeaponHolsterCancelled", client)
    end
end

function MODULE:KeyPress(client, key)
    if key == IN_RELOAD then
        local raiseSpeed = lia.config.get("WeaponRaiseSpeed", 1)
        local speedOverride = hook.Run("OverrideWeaponRaiseSpeed", client, raiseSpeed)
        if speedOverride then raiseSpeed = speedOverride end
        hook.Run("WeaponHolsterScheduled", client, raiseSpeed)
        timer.Create("WeaponHolstering" .. client:SteamID64(), raiseSpeed, 1, function() if IsValid(client) then client:toggleWepRaised() end end)
    end
end
