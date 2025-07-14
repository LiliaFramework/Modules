# Gamemode Hooks

This document lists global hooks triggered by the gamemode. You can define them on the `GM` table, inside a `MODULE`, on the `SCHEMA`, or call them anywhere with `hook.Add`.

- **MODULE** functions load only from `/modules`.

- **SCHEMA** functions live in `/schema`.

- **hook.Add** may be used from any file.

If multiple definitions of the same hook exist on `GM`, `MODULE`, or `SCHEMA`, the one loaded last overrides the others.

---

## Module Hooks

### StunGunFired

**Purpose**
Triggered when the stungun successfully tases a target.

**Parameters**

- `attacker` (`Player`): Player using the stungun.
- `target` (`Entity`): Target that was hit.

---

### PlayerStunned

**Purpose**
Called when a player enters the normal stun state.

**Parameters**

- `target` (`Player`): Player being stunned.
- `weapon` (`Weapon`): Stungun weapon.

**Returns**
- None

---

### PlayerStunCleared

**Purpose**
Fires when a normal stun ends.

**Parameters**

- `target` (`Player`): Stunned player.
- `weapon` (`Weapon`): Stungun weapon.

---

### PlayerOverStunned

**Purpose**
Called when a player is over stunned and takes damage.

**Parameters**

- `target` (`Player`): Affected player.
- `weapon` (`Weapon`): Stungun weapon.

---

### PlayerOverStunCleared

**Purpose**
Fires when the over stun effect wears off.

**Parameters**

- `target` (`Player`): Player affected.
- `weapon` (`Weapon`): Stungun weapon.

---

### StunGunTethered

**Purpose**
Runs when a rope tether is attached between the user and the target.

**Parameters**

- `attacker` (`Player`): Player using the stungun.
- `target` (`Entity`): Tethered target.

**Returns**
- None

### StunGunReloaded

**Purpose**
Triggered when a reload finishes and power is restored.

**Parameters**

- `player` (`Player`): Player reloading the weapon.
- `weapon` (`Weapon`): Stungun weapon.

**Returns**
- None

### StunGunLaserToggled

**Purpose**
Runs when the laser sight is toggled on or off.

**Parameters**

- `player` (`Player`): Owner of the weapon.
- `state` (`boolean`): New laser state.
- `weapon` (`Weapon`): Stungun weapon.

**Returns**
- None

---

## Overview

Gamemode hooks fire at various stages during play and let you modify global behavior. They can be called from your schema with `SCHEMA:HookName`, from modules using `MODULE:HookName`, or via `hook.Add`. When the same hook is defined in more than one place, whichever version loads last takes effect. All hooks are optional; if no handler is present, the default logic runs.

---

### LoadCharInformation

**Purpose**
Called after the F1 menu panel is created so additional sections can be added. Populates the character information sections of the F1 menu.

**Parameters**

- None

**Realm**
`Client`

**Returns**
- None

**Example**

```lua
-- Adds a custom hunger info field after the menu is ready.
hook.Add("LoadCharInformation", "AddHungerField", function()
    local ply = LocalPlayer()
    local char = ply:getChar()
    if not char then return end

    local function hungerField()
        local hunger = char:getData("hunger", 0)
        local color = hunger < 25 and Color(200, 50, 50) or color_white
        return string.format("%d%%", hunger), color
    end

    hook.Run("AddTextField", "General Info", "hunger", "Hunger", hungerField)
end)
```

---

### WebImageDownloaded

**Purpose**
Triggered after a remote image finishes downloading to the data folder.

**Parameters**

- `name` (`string`): Saved file name including extension.
- `path` (`string`): Local `data/` path to the image.

**Realm**
`Client`

**Returns**
- None

**Example**

```lua
hook.Add("WebImageDownloaded", "LogImage", function(name, path)
    print("Image downloaded:", name, path)
end)
```

---

