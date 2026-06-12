local MODULE = MODULE
MODULE.name = "Cutscenes"
MODULE.versionID = "public_cutscenes"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.0
MODULE.desc = "Plays simple cutscenes with synced camera movement."
MODULE.Privileges = {
    ["useCutscenes"] = {
        Name = "useCutscenes",
        MinAccess = "admin",
        Category = "cutscenes",
    },
}

MODULE.NetworkStrings = {"lia_cutscene"}
MODULE.Changelog = {
    ["1.0"] = {"Initial Release"},
}
