local MODULE = MODULE
MODULE.name = "Cutscenes"
MODULE.versionID = "public_cutscenes"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.1
MODULE.desc = "Adds a framework for simple cutscene playback, scenes defined through tables, syncing of camera movement across clients, commands to trigger cutscenes, and the ability for players to skip."
MODULE.Privileges = {
    {
        Name = "useCutscenes",
        ID = "useCutscenes",
        MinAccess = "admin",
        Category = "cutscenes",
    },
}

MODULE.NetworkStrings = {"lia_cutscene"}
