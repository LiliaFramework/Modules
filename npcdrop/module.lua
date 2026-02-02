MODULE.name = "NPC Drop"
MODULE.versionID = "public_npcdrop"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.0
MODULE.desc = "Adds NPCs that drop items on death, DropTable to define probabilities, encouragement for looting, editable drop tables per NPC type, and weighted chances for rare items."
MODULE.DropTable = {
    ["npc_zombie"] = {
        ["soda"] = 25,
        ["cola"] = 10,
        ["water"] = 50,
        ["beer"] = 15
    }
}

MODULE.Changelog = {
    ["1.0"] = "Initial Release",
}

