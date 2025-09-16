# Warrant System Module Hooks

This document describes the hooks available in the Warrant System module for managing player warrants and wanted status.

---

## PostWarrantToggle

**Purpose**

Called after a warrant has been toggled (issued or removed) for a character.

**Parameters**

* `character` (*Character*): The character whose warrant status was changed.
* `warranter` (*Player*): The player who issued or removed the warrant.
* `warranted` (*boolean*): Whether the character is now wanted (true) or not wanted (false).

**Realm**

Server.

**When Called**

This hook is triggered when:
- A warrant has been successfully toggled
- After `WarrantStatusChanged` hook
- After all notifications have been sent

**Example Usage**

```lua
-- Track warrant toggle completion
hook.Add("PostWarrantToggle", "TrackWarrantToggleCompletion", function(character, warranter, warranted)
    local char = character:getChar()
    if char then
        local warrantToggles = char:getData("warrant_toggles", 0)
        char:setData("warrant_toggles", warrantToggles + 1)
        
        -- Track warrant status changes
        local warrantStatusChanges = char:getData("warrant_status_changes", {})
        table.insert(warrantStatusChanges, {
            warranted = warranted,
            warranter = warranter:Name(),
            time = os.time()
        })
        char:setData("warrant_status_changes", warrantStatusChanges)
    end
    
    lia.log.add(warranter, "warrantToggleCompleted", character:getPlayer():Name(), warranted)
end)

-- Apply warrant toggle effects
hook.Add("PostWarrantToggle", "WarrantToggleEffects", function(character, warranter, warranted)
    -- Play toggle sound
    warranter:EmitSound("buttons/button14.wav", 75, 100)
    
    -- Apply screen effect
    warranter:ScreenFade(SCREENFADE.IN, Color(0, 255, 0, 10), 0.5, 0)
    
    -- Notify warranter
    local status = warranted and "issued" or "removed"
    warranter:notify("Warrant " .. status .. " for " .. character:getPlayer():Name() .. "!")
    
    -- Create particle effect
    local effect = EffectData()
    effect:SetOrigin(warranter:GetPos())
    effect:SetMagnitude(1)
    effect:SetScale(1)
    util.Effect("Explosion", effect)
end)

-- Track warrant statistics
hook.Add("PostWarrantToggle", "TrackWarrantStats", function(character, warranter, warranted)
    local char = warranter:getChar()
    if char then
        -- Track warrant frequency
        local warrantFrequency = char:getData("warrant_frequency", 0)
        char:setData("warrant_frequency", warrantFrequency + 1)
        
        -- Track warrant patterns
        local warrantPatterns = char:getData("warrant_patterns", {})
        table.insert(warrantPatterns, {
            character = character:getPlayer():Name(),
            warranted = warranted,
            time = os.time()
        })
        char:setData("warrant_patterns", warrantPatterns)
        
        -- Track warrant success rate
        local warrantAttempts = char:getData("warrant_attempts", 0)
        local warrantSuccesses = char:getData("warrant_successes", 0)
        char:setData("warrant_successes", warrantSuccesses + 1)
        
        local successRate = warrantSuccesses / warrantAttempts
        char:setData("warrant_success_rate", successRate)
    end
end)

-- Award warrant achievements
hook.Add("PostWarrantToggle", "WarrantAchievements", function(character, warranter, warranted)
    local char = warranter:getChar()
    if char then
        local totalWarrants = char:getData("warrant_frequency", 0)
        
        if totalWarrants == 1 then
            warranter:notify("Achievement: First Warrant!")
        elseif totalWarrants == 10 then
            warranter:notify("Achievement: Warrant Enthusiast!")
        elseif totalWarrants == 50 then
            warranter:notify("Achievement: Warrant Master!")
        end
        
        -- Check for specific warrant achievements
        if warranted then
            local warrantsIssued = char:getData("warrants_issued", 0)
            char:setData("warrants_issued", warrantsIssued + 1)
            
            if warrantsIssued == 1 then
                warranter:notify("Achievement: First Warrant Issued!")
            end
        else
            local warrantsRemoved = char:getData("warrants_removed", 0)
            char:setData("warrants_removed", warrantsRemoved + 1)
            
            if warrantsRemoved == 1 then
                warranter:notify("Achievement: First Warrant Removed!")
            end
        end
    end
end)
```

---

## PreWarrantToggle

**Purpose**

Called before a warrant is toggled (issued or removed) for a character.

**Parameters**

* `character` (*Character*): The character whose warrant status will be changed.
* `warranter` (*Player*): The player who is issuing or removing the warrant.
* `warranted` (*boolean*): Whether the character will be wanted (true) or not wanted (false).

**Realm**

Server.

**When Called**

This hook is triggered when:
- A warrant is about to be toggled
- Before the warrant status is changed
- Before `WarrantStatusChanged` hook

**Example Usage**

```lua
-- Validate warrant toggle
hook.Add("PreWarrantToggle", "ValidateWarrantToggle", function(character, warranter, warranted)
    local char = warranter:getChar()
    if char then
        -- Check if warranter can issue warrants
        if not character:CanWarrantPlayers() then
            warranter:notify("You don't have permission to issue warrants!")
            return false
        end
        
        -- Check warrant cooldown
        local lastWarrant = char:getData("last_warrant_time", 0)
        if os.time() - lastWarrant < 5 then -- 5 second cooldown
            warranter:notify("Please wait before issuing another warrant!")
            return false
        end
        
        -- Check warrant limits
        local warrantsToday = char:getData("warrants_today", 0)
        if warrantsToday >= 20 then
            warranter:notify("Daily warrant limit reached!")
            return false
        end
        
        -- Update counters
        char:setData("last_warrant_time", os.time())
        char:setData("warrants_today", warrantsToday + 1)
    end
end)

-- Apply warrant toggle restrictions
hook.Add("PreWarrantToggle", "ApplyWarrantRestrictions", function(character, warranter, warranted)
    local char = warranter:getChar()
    if char then
        -- Check if warrants are disabled
        if char:getData("warrants_disabled", false) then
            warranter:notify("Warrants are disabled!")
            return false
        end
        
        -- Check if target character can be warranted
        local targetChar = character:getChar()
        if targetChar and targetChar:getData("warrant_immune", false) then
            warranter:notify("This character is immune to warrants!")
            return false
        end
        
        -- Check warrant frequency
        local warrantFrequency = char:getData("warrant_frequency", 0)
        if warrantFrequency > 100 then
            warranter:notify("Too many warrants issued! Please take a break.")
            return false
        end
    end
end)

-- Track warrant toggle attempts
hook.Add("PreWarrantToggle", "TrackWarrantToggleAttempts", function(character, warranter, warranted)
    local char = warranter:getChar()
    if char then
        local warrantAttempts = char:getData("warrant_attempts", 0)
        char:setData("warrant_attempts", warrantAttempts + 1)
        
        -- Track warrant patterns
        local warrantPatterns = char:getData("warrant_attempt_patterns", {})
        table.insert(warrantPatterns, {
            character = character:getPlayer():Name(),
            warranted = warranted,
            time = os.time()
        })
        char:setData("warrant_attempt_patterns", warrantPatterns)
    end
    
    lia.log.add(warranter, "warrantToggleAttempt", character:getPlayer():Name(), warranted)
end)

-- Apply warrant toggle effects
hook.Add("PreWarrantToggle", "WarrantToggleEffects", function(character, warranter, warranted)
    -- Play toggle sound
    warranter:EmitSound("buttons/button15.wav", 75, 100)
    
    -- Apply screen effect
    warranter:ScreenFade(SCREENFADE.IN, Color(255, 255, 0, 10), 0.5, 0)
    
    -- Notify warranter
    local status = warranted and "issuing" or "removing"
    warranter:notify("Warrant " .. status .. " for " .. character:getPlayer():Name() .. "!")
end)
```

---

## WarrantStatusChanged

**Purpose**

Called when a character's warrant status has been changed.

**Parameters**

* `character` (*Character*): The character whose warrant status was changed.
* `warranter` (*Player*): The player who issued or removed the warrant.
* `warranted` (*boolean*): Whether the character is now wanted (true) or not wanted (false).

**Realm**

Server.

**When Called**

This hook is triggered when:
- A character's warrant status has been changed
- After `PreWarrantToggle` hook
- Before `PostWarrantToggle` hook

**Example Usage**

```lua
-- Track warrant status changes
hook.Add("WarrantStatusChanged", "TrackWarrantStatusChanges", function(character, warranter, warranted)
    local char = character:getChar()
    if char then
        local warrantStatusChanges = char:getData("warrant_status_changes", 0)
        char:setData("warrant_status_changes", warrantStatusChanges + 1)
        
        -- Track warrant history
        local warrantHistory = char:getData("warrant_history", {})
        table.insert(warrantHistory, {
            warranted = warranted,
            warranter = warranter:Name(),
            time = os.time()
        })
        char:setData("warrant_history", warrantHistory)
    end
    
    lia.log.add(warranter, "warrantStatusChanged", character:getPlayer():Name(), warranted)
end)

-- Apply warrant status change effects
hook.Add("WarrantStatusChanged", "WarrantStatusChangeEffects", function(character, warranter, warranted)
    -- Play status change sound
    warranter:EmitSound("buttons/button14.wav", 75, 100)
    
    -- Apply screen effect
    warranter:ScreenFade(SCREENFADE.IN, Color(0, 255, 0, 15), 0.5, 0)
    
    -- Notify warranter
    local status = warranted and "issued" or "removed"
    warranter:notify("Warrant " .. status .. " for " .. character:getPlayer():Name() .. "!")
    
    -- Create particle effect
    local effect = EffectData()
    effect:SetOrigin(warranter:GetPos())
    effect:SetMagnitude(1)
    effect:SetScale(1)
    util.Effect("Explosion", effect)
end)

-- Track warrant status statistics
hook.Add("WarrantStatusChanged", "TrackWarrantStatusStats", function(character, warranter, warranted)
    local char = warranter:getChar()
    if char then
        -- Track warrant frequency
        local warrantFrequency = char:getData("warrant_frequency", 0)
        char:setData("warrant_frequency", warrantFrequency + 1)
        
        -- Track warrant patterns
        local warrantPatterns = char:getData("warrant_patterns", {})
        table.insert(warrantPatterns, {
            character = character:getPlayer():Name(),
            warranted = warranted,
            time = os.time()
        })
        char:setData("warrant_patterns", warrantPatterns)
        
        -- Track warrant success rate
        local warrantAttempts = char:getData("warrant_attempts", 0)
        local warrantSuccesses = char:getData("warrant_successes", 0)
        char:setData("warrant_successes", warrantSuccesses + 1)
        
        local successRate = warrantSuccesses / warrantAttempts
        char:setData("warrant_success_rate", successRate)
    end
end)

-- Apply warrant status change restrictions
hook.Add("WarrantStatusChanged", "ApplyWarrantStatusChangeRestrictions", function(character, warranter, warranted)
    local char = warranter:getChar()
    if char then
        -- Check if warrant status changes are disabled
        if char:getData("warrant_status_changes_disabled", false) then
            warranter:notify("Warrant status changes are disabled!")
            return false
        end
        
        -- Check warrant status change cooldown
        local lastStatusChange = char:getData("last_warrant_status_change_time", 0)
        if os.time() - lastStatusChange < 2 then -- 2 second cooldown
            warranter:notify("Please wait before changing warrant status again!")
            return false
        end
        
        -- Update last status change time
        char:setData("last_warrant_status_change_time", os.time())
    end
end)

-- Award warrant status change achievements
hook.Add("WarrantStatusChanged", "WarrantStatusChangeAchievements", function(character, warranter, warranted)
    local char = warranter:getChar()
    if char then
        local totalStatusChanges = char:getData("warrant_status_changes", 0)
        
        if totalStatusChanges == 1 then
            warranter:notify("Achievement: First Warrant Status Change!")
        elseif totalStatusChanges == 10 then
            warranter:notify("Achievement: Warrant Status Changer!")
        elseif totalStatusChanges == 50 then
            warranter:notify("Achievement: Warrant Status Master!")
        end
        
        -- Check for specific status change achievements
        if warranted then
            local warrantsIssued = char:getData("warrants_issued", 0)
            char:setData("warrants_issued", warrantsIssued + 1)
            
            if warrantsIssued == 1 then
                warranter:notify("Achievement: First Warrant Issued!")
            end
        else
            local warrantsRemoved = char:getData("warrants_removed", 0)
            char:setData("warrants_removed", warrantsRemoved + 1)
            
            if warrantsRemoved == 1 then
                warranter:notify("Achievement: First Warrant Removed!")
            end
        end
    end
end)
```
