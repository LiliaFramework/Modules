# Gamemode Hooks

This document lists global hooks triggered by the gamemode. You can define them on the `GM` table, inside a `MODULE`, on the `SCHEMA`, or call them anywhere with `hook.Add`.

- **MODULE** functions load only from `/modules`.

- **SCHEMA** functions live in `/schema`.

- **hook.Add** may be used from any file.

If multiple definitions of the same hook exist on `GM`, `MODULE`, or `SCHEMA`, the one loaded last overrides the others.

---

### CanPermaRemoveEntity

**Purpose**
Called when a player attempts to permanently remove a map entity. Returning `false` prevents removal.

**Parameters**
- `client` (`Player`): Player attempting to remove the entity.
- `entity` (`Entity`): Map entity targeted for deletion.

**Realm**
`Server`

**Returns**
- `boolean`: Return `false` to disallow removal.

### OnPermaRemoveEntity

**Purpose**
Fires after a map entity has been permanently removed by a player.

**Parameters**
- `client` (`Player`): Player who removed the entity.
- `entity` (`Entity`): The removed entity.

**Realm**
`Server`

**Returns**
- None

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

