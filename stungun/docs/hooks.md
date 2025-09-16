# Stun Gun Module Hooks

This document describes the hooks available in the Stun Gun module for managing taser weapon functionality and player stun effects.

---

## PlayerDisconnected

**Purpose**

Called when a player disconnects while being affected by the stun gun.

**Parameters**

* `player` (*Player*): The player who disconnected.

**Realm**

Server.

**When Called**

This hook is triggered when:
- A player disconnects while being stunned
- The player leaves the server
- After stun effects have been applied

**Example Usage**

```lua
-- Track stun gun disconnections
hook.Add("PlayerDisconnected", "TrackStunGunDisconnections", function(player)
    local char = player:getChar()
    if char and char:getData("stunned_by_stungun", false) then
        local stunDisconnections = char:getData("stun_gun_disconnections", 0)
        char:setData("stun_gun_disconnections", stunDisconnections + 1)
        
        -- Clear stun data
        char:setData("stunned_by_stungun", false)
        char:setData("stun_gun_attacker", nil)
    end
    
    lia.log.add(player, "stunGunDisconnection")
end)

-- Clean up stun gun data
hook.Add("PlayerDisconnected", "CleanupStunGunData", function(player)
    local char = player:getChar()
    if char then
        -- Clear all stun gun related data
        char:setData("stunned_by_stungun", false)
        char:setData("stun_gun_attacker", nil)
        char:setData("stun_gun_time", nil)
        char:setData("over_stunned", false)
    end
end)
```

---

## PlayerOverStunCleared

**Purpose**

Called when a player's over-stun effect has been cleared.

**Parameters**

* `player` (*Player*): The player whose over-stun was cleared.
* `stunGun` (*Weapon*): The stun gun weapon that caused the over-stun.

**Realm**

Server.

**When Called**

This hook is triggered when:
- A player's over-stun timer expires
- The over-stun effect is manually cleared
- After `PlayerOverStunned` hook

**Example Usage**

```lua
-- Track over-stun clearing
hook.Add("PlayerOverStunCleared", "TrackOverStunClearing", function(player, stunGun)
    local char = player:getChar()
    if char then
        local overStunsCleared = char:getData("over_stuns_cleared", 0)
        char:setData("over_stuns_cleared", overStunsCleared + 1)
        
        -- Clear over-stun data
        char:setData("over_stunned", false)
        char:setData("over_stun_time", nil)
    end
    
    lia.log.add(player, "overStunCleared", stunGun:GetClass())
end)

-- Apply over-stun clear effects
hook.Add("PlayerOverStunCleared", "OverStunClearEffects", function(player, stunGun)
    -- Play clear sound
    player:EmitSound("buttons/button14.wav", 75, 100)
    
    -- Apply screen effect
    player:ScreenFade(SCREENFADE.IN, Color(0, 255, 0, 10), 0.5, 0)
    
    -- Notify player
    player:notify("Over-stun effect cleared!")
    
    -- Create particle effect
    local effect = EffectData()
    effect:SetOrigin(player:GetPos())
    effect:SetMagnitude(1)
    effect:SetScale(1)
    util.Effect("Explosion", effect)
end)
```

---

## PlayerOverStunned

**Purpose**

Called when a player has been over-stunned by the stun gun.

**Parameters**

* `player` (*Player*): The player who was over-stunned.
* `stunGun` (*Weapon*): The stun gun weapon that caused the over-stun.

**Realm**

Server.

**When Called**

This hook is triggered when:
- A player's stun gun power reaches zero
- The over-stun effect is applied
- Before `PlayerOverStunCleared` hook

**Example Usage**

```lua
-- Track over-stunning
hook.Add("PlayerOverStunned", "TrackOverStunning", function(player, stunGun)
    local char = player:getChar()
    if char then
        local overStuns = char:getData("over_stuns", 0)
        char:setData("over_stuns", overStuns + 1)
        
        -- Set over-stun data
        char:setData("over_stunned", true)
        char:setData("over_stun_time", os.time())
        char:setData("stun_gun_attacker", stunGun:GetOwner())
    end
    
    lia.log.add(player, "overStunned", stunGun:GetClass())
end)

-- Apply over-stun effects
hook.Add("PlayerOverStunned", "OverStunEffects", function(player, stunGun)
    -- Play over-stun sound
    player:EmitSound("vo/npc/male01/pain09.wav", 75, 100)
    
    -- Apply screen effect
    player:ScreenFade(SCREENFADE.IN, Color(255, 0, 0, 25), 1, 0)
    
    -- Notify player
    player:notify("You have been over-stunned!")
    
    -- Create particle effect
    local effect = EffectData()
    effect:SetOrigin(player:GetPos())
    effect:SetMagnitude(1)
    effect:SetScale(1)
    util.Effect("Explosion", effect)
end)
```

---


## PlayerStunCleared

**Purpose**

Called when a player's stun effect has been cleared.

**Parameters**

* `player` (*Player*): The player whose stun was cleared.
* `stunGun` (*Weapon*): The stun gun weapon that caused the stun.

**Realm**

Server.

**When Called**

This hook is triggered when:
- A player's stun timer expires
- The stun effect is manually cleared
- After `PlayerStunned` hook

**Example Usage**

```lua
-- Track stun clearing
hook.Add("PlayerStunCleared", "TrackStunClearing", function(player, stunGun)
    local char = player:getChar()
    if char then
        local stunsCleared = char:getData("stuns_cleared", 0)
        char:setData("stuns_cleared", stunsCleared + 1)
        
        -- Clear stun data
        char:setData("stunned_by_stungun", false)
        char:setData("stun_time", nil)
    end
    
    lia.log.add(player, "stunCleared", stunGun:GetClass())
end)

-- Apply stun clear effects
hook.Add("PlayerStunCleared", "StunClearEffects", function(player, stunGun)
    -- Play clear sound
    player:EmitSound("buttons/button14.wav", 75, 100)
    
    -- Apply screen effect
    player:ScreenFade(SCREENFADE.IN, Color(0, 255, 0, 10), 0.5, 0)
    
    -- Notify player
    player:notify("Stun effect cleared!")
    
    -- Create particle effect
    local effect = EffectData()
    effect:SetOrigin(player:GetPos())
    effect:SetMagnitude(1)
    effect:SetScale(1)
    util.Effect("Explosion", effect)
end)
```

---

## PlayerStunned

**Purpose**

Called when a player has been stunned by the stun gun.

**Parameters**

* `player` (*Player*): The player who was stunned.
* `stunGun` (*Weapon*): The stun gun weapon that caused the stun.

**Realm**

Server.

**When Called**

This hook is triggered when:
- A player is hit by the stun gun
- The stun effect is applied
- Before `PlayerStunCleared` hook

**Example Usage**

```lua
-- Track stunning
hook.Add("PlayerStunned", "TrackStunning", function(player, stunGun)
    local char = player:getChar()
    if char then
        local stuns = char:getData("stuns", 0)
        char:setData("stuns", stuns + 1)
        
        -- Set stun data
        char:setData("stunned_by_stungun", true)
        char:setData("stun_time", os.time())
        char:setData("stun_gun_attacker", stunGun:GetOwner())
    end
    
    lia.log.add(player, "stunned", stunGun:GetClass())
end)

-- Apply stun effects
hook.Add("PlayerStunned", "StunEffects", function(player, stunGun)
    -- Play stun sound
    player:EmitSound("vo/npc/male01/pain07.wav", 75, 100)
    
    -- Apply screen effect
    player:ScreenFade(SCREENFADE.IN, Color(255, 255, 0, 15), 0.5, 0)
    
    -- Notify player
    player:notify("You have been stunned!")
    
    -- Create particle effect
    local effect = EffectData()
    effect:SetOrigin(player:GetPos())
    effect:SetMagnitude(1)
    effect:SetScale(1)
    util.Effect("Explosion", effect)
end)
```

---

## StunGunFired

**Purpose**

Called when the stun gun is fired and hits a target.

**Parameters**

* `owner` (*Player*): The player who fired the stun gun.
* `target` (*Player*): The player who was hit by the stun gun.

**Realm**

Server.

**When Called**

This hook is triggered when:
- The stun gun is fired and hits a valid target
- The stun effect is about to be applied
- Before `PlayerStunned` hook

**Example Usage**

```lua
-- Track stun gun firing
hook.Add("StunGunFired", "TrackStunGunFiring", function(owner, target)
    local char = owner:getChar()
    if char then
        local stunGunFires = char:getData("stun_gun_fires", 0)
        char:setData("stun_gun_fires", stunGunFires + 1)
        
        -- Track targets
        local targets = char:getData("stun_gun_targets", {})
        targets[target:SteamID()] = (targets[target:SteamID()] or 0) + 1
        char:setData("stun_gun_targets", targets)
    end
    
    lia.log.add(owner, "stunGunFired", target:Name())
end)

-- Apply firing effects
hook.Add("StunGunFired", "StunGunFiringEffects", function(owner, target)
    -- Play firing sound
    owner:EmitSound("weapons/pistol/pistol_fire2.wav", 75, 100)
    
    -- Apply screen effect
    owner:ScreenFade(SCREENFADE.IN, Color(0, 255, 0, 10), 0.3, 0)
    
    -- Notify owner
    owner:notify("Stun gun fired at " .. target:Name() .. "!")
    
    -- Create particle effect
    local effect = EffectData()
    effect:SetOrigin(owner:GetPos())
    effect:SetMagnitude(1)
    effect:SetScale(1)
    util.Effect("Explosion", effect)
end)
```

---

## StunGunLaserToggled

**Purpose**

Called when the stun gun's laser sight is toggled.

**Parameters**

* `owner` (*Player*): The player who owns the stun gun.
* `laserOn` (*boolean*): Whether the laser is now on or off.
* `stunGun` (*Weapon*): The stun gun weapon.

**Realm**

Server.

**When Called**

This hook is triggered when:
- The stun gun's laser sight is toggled
- The secondary fire button is pressed
- The laser state changes

**Example Usage**

```lua
-- Track laser toggling
hook.Add("StunGunLaserToggled", "TrackLaserToggling", function(owner, laserOn, stunGun)
    local char = owner:getChar()
    if char then
        local laserToggles = char:getData("stun_gun_laser_toggles", 0)
        char:setData("stun_gun_laser_toggles", laserToggles + 1)
        
        -- Track laser state
        char:setData("stun_gun_laser_on", laserOn)
    end
    
    lia.log.add(owner, "stunGunLaserToggled", laserOn)
end)

-- Apply laser toggle effects
hook.Add("StunGunLaserToggled", "LaserToggleEffects", function(owner, laserOn, stunGun)
    -- Play toggle sound
    owner:EmitSound("ui/buttonclick.wav", 75, 100)
    
    -- Apply screen effect
    owner:ScreenFade(SCREENFADE.IN, Color(255, 0, 0, 5), 0.2, 0)
    
    -- Notify owner
    local status = laserOn and "on" or "off"
    owner:notify("Stun gun laser " .. status .. "!")
end)
```

---

## StunGunReloaded

**Purpose**

Called when the stun gun has been reloaded.

**Parameters**

* `owner` (*Player*): The player who owns the stun gun.
* `stunGun` (*Weapon*): The stun gun weapon that was reloaded.

**Realm**

Server.

**When Called**

This hook is triggered when:
- The stun gun reload animation completes
- The weapon is fully reloaded
- After the reload timer expires

**Example Usage**

```lua
-- Track stun gun reloading
hook.Add("StunGunReloaded", "TrackStunGunReloading", function(owner, stunGun)
    local char = owner:getChar()
    if char then
        local stunGunReloads = char:getData("stun_gun_reloads", 0)
        char:setData("stun_gun_reloads", stunGunReloads + 1)
    end
    
    lia.log.add(owner, "stunGunReloaded")
end)

-- Apply reload effects
hook.Add("StunGunReloaded", "StunGunReloadEffects", function(owner, stunGun)
    -- Play reload sound
    owner:EmitSound("weapons/pistol/pistol_reload1.wav", 75, 100)
    
    -- Apply screen effect
    owner:ScreenFade(SCREENFADE.IN, Color(0, 255, 0, 10), 0.5, 0)
    
    -- Notify owner
    owner:notify("Stun gun reloaded!")
    
    -- Create particle effect
    local effect = EffectData()
    effect:SetOrigin(owner:GetPos())
    effect:SetMagnitude(1)
    effect:SetScale(1)
    util.Effect("Explosion", effect)
end)
```

---

## StunGunTethered

**Purpose**

Called when the stun gun creates a tether to a target.

**Parameters**

* `owner` (*Player*): The player who owns the stun gun.
* `target` (*Player*): The player who is tethered to the stun gun.

**Realm**

Server.

**When Called**

This hook is triggered when:
- The stun gun creates a tether to a valid target
- The rope constraint is established
- Before `StunGunFired` hook

**Example Usage**

```lua
-- Track stun gun tethering
hook.Add("StunGunTethered", "TrackStunGunTethering", function(owner, target)
    local char = owner:getChar()
    if char then
        local stunGunTethers = char:getData("stun_gun_tethers", 0)
        char:setData("stun_gun_tethers", stunGunTethers + 1)
        
        -- Track tether targets
        local tetherTargets = char:getData("stun_gun_tether_targets", {})
        tetherTargets[target:SteamID()] = (tetherTargets[target:SteamID()] or 0) + 1
        char:setData("stun_gun_tether_targets", tetherTargets)
    end
    
    lia.log.add(owner, "stunGunTethered", target:Name())
end)

-- Apply tether effects
hook.Add("StunGunTethered", "StunGunTetherEffects", function(owner, target)
    -- Play tether sound
    owner:EmitSound("weapons/pistol/pistol_empty.wav", 75, 100)
    
    -- Apply screen effect
    owner:ScreenFade(SCREENFADE.IN, Color(0, 0, 255, 10), 0.5, 0)
    
    -- Notify owner
    owner:notify("Stun gun tethered to " .. target:Name() .. "!")
    
    -- Create particle effect
    local effect = EffectData()
    effect:SetOrigin(owner:GetPos())
    effect:SetMagnitude(1)
    effect:SetScale(1)
    util.Effect("Explosion", effect)
end)
```
