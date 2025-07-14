# Gamemode Hooks

This document lists global hooks triggered by the gamemode. You can define them on the `GM` table, inside a `MODULE`, on the `SCHEMA`, or call them anywhere with `hook.Add`.

- **MODULE** functions load only from `/modules`.

- **SCHEMA** functions live in `/schema`.

- **hook.Add** may be used from any file.

If multiple definitions of the same hook exist on `GM`, `MODULE`, or `SCHEMA`, the one loaded last overrides the others.

---

## Module Hooks

### ExtendedDescriptionOpened
Fired after the view panel is created when a player opens an extended description.

**Parameters**
- `ply` (`Player`): The player whose description is being viewed.
- `frame` (`Panel`): The created frame.
- `text` (`string`): Description text.
- `url` (`string`): Reference image URL.

### ExtendedDescriptionClosed
Triggered when the view panel is closed.

**Parameters**
- `ply` (`Player`): The player whose description was viewed.
- `text` (`string`): Description text.
- `url` (`string`): Reference image URL.

### ExtendedDescriptionEditOpened
Triggered when the edit menu is opened.

**Parameters**
- `frame` (`Panel`): The edit frame.
- `steamName` (`string`): Steam name of the character being edited.

### ExtendedDescriptionEditClosed
Runs when the edit menu is closed without submitting.

**Parameters**
- `steamName` (`string`): Character steam name.

### ExtendedDescriptionEditSubmitted
Runs when the edit form is submitted.

**Parameters**
- `steamName` (`string`): Character steam name.
- `url` (`string`): Reference image URL.
- `text` (`string`): Description text.

### PreExtendedDescriptionUpdate
Serverside hook fired before a player's description data updates.

**Parameters**
- `client` (`Player`): Player whose description is changing.
- `url` (`string`): Reference image URL.
- `text` (`string`): New description text.

### ExtendedDescriptionUpdated
Serverside hook fired after a player's description data is updated.

**Parameters**
- `client` (`Player`): Player whose description changed.
- `url` (`string`): Reference image URL.
- `text` (`string`): New description text.

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

