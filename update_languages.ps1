# PowerShell script to update language files for modules

# Define the module mappings
$moduleMap = @{
    "captions"             = @{
        "name" = "Captions"
        "desc" = "Offers an API for timed on-screen captions suited for tutorials or story events. Captions can be triggered from the server or client and last for a chosen duration."
    }
    "cards"                = @{
        "name" = "Cards"
        "desc" = "Adds a full deck of playing cards that can be shuffled and drawn. Card draws sync to all players for simple in-game minigames."
    }
    "cigs"                 = @{
        "name" = "Cigarettes"
        "desc" = "Adds cigarette items that burn down over time, producing smoke and ash effects for added ambience."
    }
    "cinematictext"        = @{
        "name" = "Cinematic Text"
        "desc" = "Shows dramatic splash text with optional letterbox bars. Text smoothly fades in and out to enhance cutscenes or announcements."
    }
    "communitycommands"    = @{
        "name" = "Community Commands"
        "desc" = "Provides chat commands that open links to community resources such as the website or Discord. Command names and URLs are fully configurable."
    }
    "compass"              = @{
        "name" = "Compass"
        "desc" = "Shows a HUD compass that rotates with your view and can mark spotted locations. Workshop icons enhance its appearance."
    }
    "corpseid"             = @{
        "name" = "Corpse Identification"
        "desc" = "Lets players inspect corpses after a brief delay to see who they were. The victim's name appears above the body and the action is logged."
    }
    "cutscenes"            = @{
        "name" = "Simple Cutscenes"
        "desc" = "Offers a simple framework for scripted cutscenes with synced camera movement. Scenes can be triggered by command and skipped if allowed."
    }
    "developmentserver"    = @{
        "name" = "Development Server"
        "desc" = "Enables a special development mode for testing new features. When active, dev-only functions can be executed and all actions are logged."
    }
    "discordrelay"         = @{
        "name" = "Discord Relay"
        "desc" = "Relays selected server logs to Discord using configurable webhook URLs. Supports multiple channels and filters for organized updates."
    }
    "donator"              = @{
        "name" = "Donator Perks"
        "desc" = "Provides libraries to manage donor ranks and perks. Perks can be configured per tier and players may receive extra character slots."
    }
    "doorkick"             = @{
        "name" = "Door Kick"
        "desc" = "Allows players to breach doors by kicking them open. The action flings the door aside and is fully logged for staff review."
    }
    "enhanceddeath"        = @{
        "name" = "Hospital Respawn"
        "desc" = "Overrides default death mechanics to respawn players at hospital locations instead of their death position."
    }
    "extendeddescriptions" = @{
        "name" = "Extended Descriptions"
        "desc" = "Lets items include lengthy descriptions that are localized for different languages. Text wraps automatically to present detailed lore."
    }
    "freelook"             = @{
        "name" = "Free Look"
        "desc" = "Enables freelook so players can glance around without turning their body. A toggle key and sensitivity options offer tactical awareness."
    }
    "gamemasterpoints"     = @{
        "name" = "Gamemaster Points"
        "desc" = "Allows game masters to save, share, and teleport to named points around the map. Useful for fast navigation during events and administration."
    }
    "hud_extras"           = @{
        "name" = "HUD Extras"
        "desc" = "Adds optional HUD widgets like an FPS counter and performance stats. The system is extensible so other modules can display their own info."
    }
    "inventory"            = @{
        "name" = "Weighted Inventory"
        "desc" = "Adds a weight-based inventory system that limits what a character can haul. Drag-and-drop management encourages careful packing."
    }
    "joinleavemessages"    = @{
        "name" = "Join Leave Messages"
        "desc" = "Announces when players join or leave the server and can relay these messages to Discord. Individuals may disable the notifications."
    }
    "loyalism"             = @{
        "name" = "Loyalism"
        "desc" = "Tracks player loyalty tiers which unlock the /partytier command and other rewards. Tiers can progress automatically based on actions."
    }
    "mapcleaner"           = @{
        "name" = "Map Cleaner"
        "desc" = "Periodically removes stray props and debris to keep performance high. Important entities can be whitelisted and admins may clean up manually."
    }
    "modeltweaker"         = @{
        "name" = "Model Tweaker"
        "desc" = "Spawns an admin-only entity for scaling and rotating props. Changes persist across restarts and can be undone if needed."
    }
    "npcspawner"           = @{
        "name" = "NPC Spawner"
        "desc" = "Spawns NPCs at preset points on a schedule. Staff can force spawns manually and all actions are logged."
    }
    "permaremove"          = @{
        "name" = "Perma Remove"
        "desc" = "Allows admins to permanently delete unwanted map entities. Each removal is confirmed and recorded for later review."
    }
    "radio"                = @{
        "name" = "Radio"
        "desc" = "Adds a radio communication system with configurable fonts and models. Players can tune to different frequencies or carry handheld radios."
    }
    "raisedweapons"        = @{
        "name" = "Raised Weapons"
        "desc" = "Lowers your weapon while sprinting to prevent accidental fire, then raises it again after a delay. Works with both guns and melee weapons."
    }
    "rumour"               = @{
        "name" = "Anonymous Rumors"
        "desc" = "Introduces an anonymous /rumour command so players can spread gossip without giving away their identity. All messages are logged and rate limited."
    }
    "simple_lockpicking"   = @{
        "name" = "Lockpicking"
        "desc" = "Offers a basic lockpick tool for brute-forcing doors. Attempts are logged, and pick time and break chance are configurable."
    }
    "slots"                = @{
        "name" = "Slot Machine"
        "desc" = "Introduces a slot machine minigame using a workshop model. Players can gamble for configurable payouts with sounds and animations."
    }
    "tying"                = @{
        "name" = "Tying"
        "desc" = "Adds handcuff items to restrain players, recording every tie and untie action. Prisoners can attempt timed escapes for added drama."
    }
    "utilities"            = @{
        "name" = "Code Utilities"
        "desc" = "Supplies additional helper functions under lia.util for use by other modules. Simplifies networking and other common scripting tasks."
    }
    "warrants"             = @{
        "name" = "Warrant System"
        "desc" = "Implements a warrant system so staff can issue, view, and revoke warrants. Players are notified and all actions are logged with optional expirations."
    }
    "wartable"             = @{
        "name" = "War Table"
        "desc" = "Creates an interactive 3D war table for coordinating operations. Staff can place markers and switch between different map layouts."
    }
    "wordfilter"           = @{
        "name" = "Word Filter"
        "desc" = "Monitors chat for banned words using a customizable blacklist. Admin commands make managing filters easy."
    }
}

# Process each module
foreach ($module in $moduleMap.Keys) {
    $langFile = "$module\languages\english.lua"
    if (Test-Path $langFile) {
        Write-Host "Processing $module..."
        # Add the module name and description to the language file
        # This would need manual implementation for each file structure
    }
}

Write-Host "Script created. Manual processing required for each module."
