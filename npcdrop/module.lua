MODULE.name = "NPC Drops"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.14
MODULE.desc = "Sets up loot tables so specific NPCs drop items when killed. Weighted chances encourage players to search bodies after combat."
MODULE.DropTable = {
    ["npc_zombie"] = {
        ["soda"] = 25,
        ["cola"] = 10,
        ["water"] = 50,
        ["beer"] = 15
    }
}

MODULE.Public = true
MODULE.Features = {"Adds NPCs that drop items on death", "Adds DropTable to define probabilities", "Adds encouragement for looting", "Adds editable drop tables per NPC type", "Adds weighted chances for rare items"}
