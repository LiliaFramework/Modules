# List of Modules

## Modules

<details>
<summary>Advertisements</summary>

- **Name**: Advertisements
- **Description**: Implements a paid /advert command for server-wide announcements. Messages are colored, logged, and throttled by a cooldown to curb spam.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.5

- Enhanced documentation with detailed configuration options including AdvertPrice and AdvertCooldown settings with usage guidelines
- Added comprehensive hooks documentation for the AdvertSent hook with multiple complexity examples
- Improved documentation structure and formatting for better readability

### Version 1.4

- Added comprehensive configuration documentation

### Version 1.3

- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/advert.zip)

</details>

<details>
<summary>AFK Protection</summary>

- **Name**: AFK Protection
- **Description**: Comprehensive AFK protection system that automatically detects inactive players, prevents exploitation of AFK players, and integrates with restraint systems. Features configurable AFK detection, admin commands, multi-language support, and protection against various player actions.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2

- Better UI

### Version 1.1

- Added comprehensive multi-language support (English, Spanish, French, German, Portuguese, Italian)
- Updated all hardcoded strings to use language system
- Enhanced module description with detailed feature list
- Improved documentation with complete feature overview
- Updated version number to reflect improvements
- Add Docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/afk.zip)

</details>

<details>
<summary>Alcoholism</summary>

- **Name**: Alcoholism
- **Description**: Adds drinkable alcohol that increases a player's intoxication level. High BAC blurs vision and slows movement until the effect wears off.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.5

- Fixed localization format error in `alcoholDesc` string by correcting `%s%` to `%s%%` in all language files (English, Spanish, Portuguese, Italian, German, French)

### Version 1.4

- Added comprehensive configuration documentation

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency:
  - `ResetBAC()` ? `resetBAC()`
  - `AddBAC()` ? `addBAC()`
  - `IsDrunk()` ? `isDrunk()`
  - `GetBAC()` ? `getBAC()`

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/alcoholism.zip)

</details>

<details>
<summary>Anonymous Rumors</summary>

- **Name**: Anonymous Rumors
- **Description**: Adds an anonymous rumour chat command, hiding of the sender's identity, encouragement for roleplay intrigue, a cooldown to prevent spam, and admin logging of rumour messages.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added custom colors for rumor messages
- [RUMOUR] prefix now displays in orange color
- Rumor message text displays in white color
- Colors are now hardcoded local variables instead of configurable settings

### Version 1.2

- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/rumour.zip)

</details>

<details>
<summary>Auto Restarter</summary>

- **Name**: Auto Restarter
- **Description**: Schedules automatic server restarts at set intervals. Players see a countdown so they can prepare before the map changes.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation
- Configuration updates and improvements

### Version 1.2

- Added comprehensive hooks documentation


### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/autorestarter.zip)

</details>

<details>
<summary>BodyGroup Closet</summary>

- **Name**: BodyGroup Closet
- **Description**: Spawns a bodygroup closet where players can edit their model's bodygroups. Admins may inspect others and configure the closet's model.
- <details><summary>Changelog</summary>

# Changelog

### Version 2.1

- Removed category wrapper from bodygroup UI to provide more space for controls
- Bodygroup sliders now display directly in the scroll panel without category container

### Version 2.0

- Simplified bodygroup UI by returning to liaCategory with AddItem approach
- Category now expands by default to immediately show all bodygroup options
- Removed complex contents panel management for cleaner, more reliable layout

### Version 1.9

- Fixed bodygroup slider visibility and spacing issues by improving liaCategory AddItem method
- Added automatic contents panel creation for proper layout management
- Category now expands by default to show bodygroups immediately

### Version 1.8

- Changed "Finish" button to "Submit" button with proper localization
- Updated button component from liaMediumButton to liaButton
- Submit button now always visible (no longer removed when no bodygroups/skins available)
- Added submit language entries for all supported languages

### Version 1.7

- UI components to use Lilia framework components (liaSlideBox, liaMediumButton, liaScrollPanel, liaCategory, liaFrame)
- BodygrouperModelPaint and BodygrouperPostDrawModel hooks for custom rendering
- Changed from DNumSlider to liaSlideBox with improved SetRange API

### Version 1.6

- Updated Vector method calls to use proper PascalCase naming (`distance` → `Distance`)

### Version 1.5

- Added comprehensive configuration documentation

### Version 1.4

- Added comprehensive hooks documentation


### Version 1.3

- Language files for all supported languages (English, French, German, Italian, Portuguese, Spanish)

### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/bodygrouper.zip)

</details>

<details>
<summary>Broadcasts</summary>

- **Name**: Broadcasts
- **Description**: Allows staff to broadcast messages to chosen factions or classes. Every broadcast is logged and controlled through CAMI privileges.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.2

- Added comprehensive hooks documentation


### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/broadcasts.zip)

</details>

<details>
<summary>Captions</summary>

- **Name**: Captions
- **Description**: Offers an API for timed on-screen captions suited for tutorials or story events. Captions can be triggered from the server or client and last for a chosen duration.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive hooks documentation
- Added libraries documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/captions.zip)

</details>

<details>
<summary>Cards</summary>

- **Name**: Cards
- **Description**: Adds a full deck of playing cards that can be shuffled and drawn. Card draws sync to all players for simple in-game minigames.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/cards.zip)

</details>

<details>
<summary>Chat Messages</summary>

- **Name**: Chat Messages
- **Description**: Periodically posts automated advert messages in chat on a timer. Keeps players informed with rotating tips even when staff are offline.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2

- Added comprehensive hooks documentation


### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/chatmessages.zip)

</details>

<details>
<summary>Cinematic Text</summary>

- **Name**: Cinematic Text
- **Description**: Adds displays of cinematic splash text overlays, screen darkening with letterbox bars, support for scripted scenes, timed fades for dramatic effect, and customizable text fonts.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.5

- Removed custom font configuration option
- Replaced custom font registrations with standard LiliaFont system
- Simplified font usage for better consistency

### Version 1.4

- Added comprehensive configuration documentation
- Configuration updates and improvements

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/cinematictext.zip)

</details>

<details>
<summary>Climbing</summary>

- **Name**: Climbing
- **Description**: Adds the ability to climb ledges using movement keys, custom climbing animations, and hooks for climb attempts.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.2

- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/climb.zip)

</details>

<details>
<summary>Code Utilities</summary>

- **Name**: Code Utilities
- **Description**: Adds extra helper functions in lia.util, simplified utilities for common scripting tasks, a central library used by other modules, utilities for networking data, and shared constants for modules.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.5

- Updated Vector method calls to use proper PascalCase naming (`distance` → `Distance`)

### Version 1.4

- Added comprehensive hooks documentation
- Added libraries documentation

### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency:
  - `SpeedTest` → `speedTest`
  - `DaysBetween` → `daysBetween`
  - `LerpHSV` → `lerpHSV`
  - `Darken` → `darken`
  - `LerpColor` → `lerpColor`
  - `Blend` → `blend`
  - `Rainbow` → `rainbow`
  - `ColorCycle` → `colorCycle`
  - `ColorToHex` → `colorToHex`
  - `Lighten` → `lighten`
  - `SecondsToDHMS` → `secondsToDHMS`
  - `HMSToSeconds` → `hMSToSeconds`
  - `FormatTimestamp` → `formatTimestamp`
  - `WeekdayName` → `weekdayName`
  - `TimeUntil` → `timeUntil`
  - `CurrentLocalTime` → `currentLocalTime`
  - `TimeDifference` → `timeDifference`
  - `SerializeVector` → `serializeVector`
  - `DeserializeVector` → `deserializeVector`
  - `SerializeAngle` → `serializeAngle`
  - `DeserializeAngle` → `deserializeAngle`

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/utilities.zip)

</details>

<details>
<summary>Community Commands</summary>

- **Name**: Community Commands
- **Description**: Adds chat commands to open community links, easy sharing of workshop and docs, configurable commands via settings, localization for command names, and the ability to add custom URLs.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/communitycommands.zip)

</details>

<details>
<summary>Cursor</summary>

- **Name**: Cursor
- **Description**: Adds a toggleable custom cursor for the UI, a purely client-side implementation, improved menu navigation, a hotkey to quickly show or hide the cursor, and compatibility with other menu modules.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/cursor.zip)

</details>

<details>
<summary>Cutscenes</summary>

- **Name**: Cutscenes
- **Description**: Adds a framework for simple cutscene playback, scenes defined through tables, syncing of camera movement across clients, commands to trigger cutscenes, and the ability for players to skip.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/cutscenes.zip)

</details>

<details>
<summary>Damage Numbers</summary>

- **Name**: Damage Numbers
- **Description**: Adds floating combat text when hitting targets, different colors for damage types, display of damage dealt and received, scaling text based on damage amount, and client option to disable numbers.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.5

- Updated Vector method calls to use proper PascalCase naming (`distance` → `Distance`)

### Version 1.4

- Added comprehensive configuration documentation
- Configuration updates and improvements

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/damagenumbers.zip)

</details>

<details>
<summary>Development HUD</summary>

- **Name**: Development HUD
- **Description**: Adds a staff-only development HUD, font customization via DevHudFont, a requirement for the CAMI privilege, real-time server performance metrics, and a toggle command to show or hide the HUD.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.5

- Updated Vector method calls to use proper PascalCase naming (`distance` → `Distance`)

### Version 1.4

- Added comprehensive configuration documentation
- Configuration updates and improvements

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/developmenthud.zip)

</details>

<details>
<summary>Development Server</summary>

- **Name**: Development Server
- **Description**: Adds a development server mode for testing, the ability to run special development functions, a toggle via configuration, an environment flag for dev commands, and logging of executed dev actions.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/developmentserver.zip)

</details>

<details>
<summary>Donator</summary>

- **Name**: Donator
- **Description**: Adds libraries to manage donor perks, tracking for donor ranks and perks, configurable perks by tier, and commands to adjust character slots.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.4

- Added comprehensive configuration documentation

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency:
  - `GetAdditionalCharSlots()` ? `getAdditionalCharSlots()`
  - `SetAdditionalCharSlots()` ? `setAdditionalCharSlots()`
  - `GiveAdditionalCharSlots()` ? `giveAdditionalCharSlots()`

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/donator.zip)

</details>

<details>
<summary>Door Kick</summary>

- **Name**: Door Kick
- **Description**: Adds the ability to kick doors open with an animation, logging of door kick events, and a fun breach mechanic with physics force to fling doors open.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.5

- Updated Vector method calls to use proper PascalCase naming (`distance` → `Distance`)

### Version 1.4

- Added comprehensive configuration documentation

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/doorkick.zip)

</details>

<details>
<summary>Extended Descriptions</summary>

- **Name**: Extended Descriptions
- **Description**: Adds support for long item descriptions, localization for multiple languages, better RP text display, automatic line wrapping, and fallback to short descriptions.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.4

- Changed button component from liaSmallButton to liaButton for consistency

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/extendeddescriptions.zip)

</details>

<details>
<summary>First Person Effects</summary>

- **Name**: First Person Effects
- **Description**: Adds head bob and view sway, camera motion synced to actions, a realistic first-person feel, and adjustable intensity via config.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.4

- Added comprehensive configuration documentation

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/firstpersoneffects.zip)

</details>

<details>
<summary>Flashlight</summary>

- **Name**: Flashlight
- **Description**: Adds a serious flashlight with dynamic light, darkening of surroundings when turned off, adjustable brightness, and keybind toggle support.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.4

- Standardized flashlight toggle sound behavior
- Simplified sound playback logic

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/flashlight.zip)

</details>

<details>
<summary>Free Look</summary>

- **Name**: Free Look
- **Description**: Adds the ability to look around without turning the body, a toggle key similar to EFT, movement direction preservation, and adjustable sensitivity while freelooking.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/freelook.zip)

</details>

<details>
<summary>Gamemaster Points</summary>

- **Name**: Gamemaster Points
- **Description**: Adds teleport points for game masters, quick navigation across large maps, saving of locations for reuse, a command to list saved points, and sharing of points with other staff.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.4

- Changed button font from ChatFont to LiliaFont.16 for better UI consistency

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Client library functions and optimizations

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/gamemasterpoints.zip)

</details>

<details>
<summary>Hospitals</summary>

- **Name**: Hospitals
- **Description**: Adds respawning of players at hospitals with support for multiple hospital spawn locations on different maps.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/hospitals.zip)

</details>

<details>
<summary>HUD Extras</summary>

- **Name**: HUD Extras
- **Description**: Adds extra HUD elements like an FPS counter, fonts configurable with FPSHudFont, hooks so other modules can extend, performance stats display, and toggles for individual HUD elements.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.4

- Added comprehensive configuration documentation
- Configuration updates and improvements

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated blur effect to use network variables (`getNetVar`) instead of local variables (`getLocalVar`) for better synchronization

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/hud_extras.zip)

</details>

<details>
<summary>Instakill</summary>

- **Name**: Instakill
- **Description**: Adds instant kill on headshots, lethality configurable per weapon, extra tension to combat, and integration with damage numbers.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/instakill.zip)

</details>

<details>
<summary>Join Leave Messages</summary>

- **Name**: Join Leave Messages
- **Description**: Adds announcements when players join, notifications on disconnect, improved community awareness, relay of messages to Discord, and per-player toggle to hide messages.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/joinleavemessages.zip)

</details>

<details>
<summary>Load Messages</summary>

- **Name**: Load Messages
- **Description**: Adds faction-based load messages, execution when players first load a character, customizable message text, color-coded formatting options, and per-faction enable toggles.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/loadmessages.zip)

</details>

<details>
<summary>Loyalism</summary>

- **Name**: Loyalism
- **Description**: Adds a loyalty tier system for players, the /partytier command access, permission control through flags, automatic tier progression, and customizable rewards per tier.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/loyalism.zip)

</details>

<details>
<summary>Map Cleaner</summary>

- **Name**: Map Cleaner
- **Description**: Adds periodic cleaning of map debris, a configurable interval, reduced server lag, a whitelist for protected entities, and manual cleanup commands.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/mapcleaner.zip)

</details>

<details>
<summary>Model Pay</summary>

- **Name**: Model Pay
- **Description**: Adds payment to characters based on model, custom wage definitions, integration into the economy, config to exclude certain models, and logs of wages issued.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.2
- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release



</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/modelpay.zip)

</details>

<details>
<summary>Model Tweaker</summary>

- **Name**: Model Tweaker
- **Description**: Adds an entity to tweak prop models, adjustments for scale and rotation, easy UI controls, saving of tweaked props between restarts, and undo support for recent tweaks.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.4

- Added comprehensive configuration documentation

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/modeltweaker.zip)

</details>

<details>
<summary>NPC Drop</summary>

- **Name**: NPC Drop
- **Description**: Adds NPCs that drop items on death, DropTable to define probabilities, encouragement for looting, editable drop tables per NPC type, and weighted chances for rare items.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2

- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/npcdrop.zip)

</details>

<details>
<summary>NPC Money</summary>

- **Name**: NPC Money
- **Description**: Adds NPCs that give money to players on death, MoneyTable to define rewards, editable money amounts per NPC type, and configurable default values.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/npcmoney.zip)

</details>

<details>
<summary>NPC Spawner</summary>

- **Name**: NPC Spawner
- **Description**: Adds automatic NPC spawns at points, the ability for admins to force spawns, logging of spawn actions, and configuration for spawn intervals.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2

- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/npcspawner.zip)

</details>

<details>
<summary>Perma Remove</summary>

- **Name**: Perma Remove
- **Description**: Adds ability to permanently delete map entities, logging for each removed entity, an admin-only command, confirmation prompts before removal, and restore list to undo mistakes.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.2

- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/permaremove.zip)

</details>

<details>
<summary>Radio</summary>

- **Name**: Radio
- **Description**: Adds a radio chat channel for players, font configuration via RadioFont, workshop models for radios, frequency channels for groups, and handheld radio items.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.6

- Updated Vector method calls to use proper PascalCase naming (`distance` → `Distance`)

### Version 1.5

- Added comprehensive configuration documentation
- Configuration updates and improvements

### Version 1.4

- Added comprehensive hooks documentation


### Version 1.3

- Shared library functions and language files for all supported languages (English, French, German, Italian, Portuguese, Spanish)
- Configuration and shared library optimizations

### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/radio.zip)

</details>

<details>
<summary>Raised Weapons</summary>

- **Name**: Raised Weapons
- **Description**: Adds auto-lowering of weapons when running, a raise delay set by WeaponRaiseSpeed, prevention of accidental fire, a toggle to keep weapons lowered, and compatibility with melee weapons.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.4

- Updated Angle method calls to use proper PascalCase naming (`up` → `Up`, `Forward` → `Forward`, `right` → `Right`, `rotateAroundAxis` → `RotateAroundAxis`)

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/raisedweapons.zip)

</details>

<details>
<summary>Realistic View</summary>

- **Name**: Realistic View
- **Description**: Adds a first-person view that shows the full body, immersive camera transitions, compatibility with animations, smooth leaning animations, and optional third-person override.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.4

- Updated Angle method calls to use proper PascalCase naming (`up` → `Up`)

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/realisticview.zip)

</details>

<details>
<summary>Shoot Lock</summary>

- **Name**: Shoot Lock
- **Description**: Adds the ability to shoot door locks to open them, a quick breach alternative, a loud action that may alert others, and chance-based lock destruction.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.4

- Updated Vector method calls to use proper PascalCase naming (`distance` → `Distance`)

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/shootlock.zip)

</details>

<details>
<summary>Simple Lockpicking</summary>

- **Name**: Simple Lockpicking
- **Description**: Adds a simple lockpick tool for doors, logging of successful picks, brute-force style gameplay, configurable pick time, and chance for tools to break.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.2

- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/simple_lockpicking.zip)

</details>

<details>
<summary>Slot Machine</summary>

- **Name**: Slot Machine
- **Description**: Adds a slot machine minigame, a workshop model for the machine, handling of payouts to winners, customizable payout odds, and sound and animation effects.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2

- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/slots.zip)

</details>

<details>
<summary>Slow Weapons</summary>

- **Name**: Slow Weapons
- **Description**: Adds slower movement while holding heavy weapons, speed penalties defined per weapon, encouragement for strategic choices, customizable weapon speed table, and automatic speed restore when switching.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2

- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/slowweapons.zip)

</details>

<details>
<summary>Steam Group Rewards</summary>

- **Name**: Steam Group Rewards
- **Description**: Provides Steam group membership rewards system that automatically checks group membership and gives money rewards to players who join your Steam group.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.1

- Added comprehensive configuration documentation

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/steamgrouprewards.zip)

</details>

<details>
<summary>View Manipulation</summary>

- **Name**: View Manipulation
- **Description**: Adds VManip animation support, hand gestures for items, functionality within Lilia, API for custom gesture triggers, and fallback animations when VManip is missing.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.2

- Added comprehensive hooks documentation

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/vmanip.zip)

</details>

<details>
<summary>War Table</summary>

- **Name**: War Table
- **Description**: Adds an interactive 3D war table, the ability to plan operations on a map, a workshop model, marker placement for strategies, and support for multiple map layouts.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.5

- Updated Angle method calls to use proper PascalCase naming (`rotateAroundAxis` → `RotateAroundAxis`)

### Version 1.4

- Added comprehensive configuration documentation

### Version 1.3

- Added comprehensive hooks documentation


### Version 1.2

- Updated function naming convention from PascalCase to camelCase for consistency

### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/wartable.zip)

</details>

<details>
<summary>Word Filter</summary>

- **Name**: Word Filter
- **Description**: Adds chat word filtering, blocking of banned phrases, an easy-to-extend list, and admin commands to modify the list.
- <details><summary>Changelog</summary>

# Changelog

### Version 1.3

- Added comprehensive configuration documentation

### Version 1.2

- Added comprehensive hooks documentation


### Version 1.1

- Created docs

### Version 1.0

- Initial Release


</details>
- [Download Button](https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/wordfilter.zip)

</details>

