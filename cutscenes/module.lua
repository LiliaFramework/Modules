local MODULE = MODULE
MODULE.name = "Cutscenes"
MODULE.uniqueID = "public_cutscenes"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.24
MODULE.desc = "Adds a framework for simple cutscene playback, scenes defined through tables, syncing of camera movement across clients, commands to trigger cutscenes, and the ability for players to skip."
MODULE.Features = {"Adds a framework for simple cutscene playback", "Adds scenes defined through tables", "Adds syncing of camera movement across clients", "Adds commands to trigger cutscenes", "Adds the ability for players to skip"}
MODULE.Privileges = {
    {
        Name = "useCutscenes",
        ID = "useCutscenes",
        MinAccess = "admin",
        Category = "cutscenes",
    },
}