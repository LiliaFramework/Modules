lia.voice = {}
lia.voice.list = {}
lia.voice.chatTypes = {}
lia.voice.checks = lia.voice.checks or {}
MODULE.name = "Text To Voice"
MODULE.author = "76561198312513285"
MODULE.discord = "@liliaplayer"
MODULE.version = "Stock"
MODULE.desc = "Adds Phrases that can play sounds."
MODULE.Dependencies = {
    {
        File = MODULE.path .. "/voice.lua",
        Realm = "shared",
    },
    {
        File = MODULE.path .. "/definitons.lua",
        Realm = "shared",
    },
}
