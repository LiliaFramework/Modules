MODULE.name = "NPC Drop"
MODULE.uniqueID = "public_npcdrop"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.18
MODULE.desc = "Adds NPCs that drop items on death, DropTable to define probabilities, encouragement for looting, editable drop tables per NPC type, and weighted chances for rare items."
MODULE.DropTable = {
    ["npc_zombie"] = {
        ["soda"] = 25,
        ["cola"] = 10,
        ["water"] = 50,
        ["beer"] = 15
    }
}

MODULE.Features = {"Adds NPCs that drop items on death", "Adds DropTable to define probabilities", "Adds encouragement for looting", "Adds editable drop tables per NPC type", "Adds weighted chances for rare items"}