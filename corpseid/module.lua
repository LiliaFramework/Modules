MODULE.name = "Corpse ID"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.6"
MODULE.desc = "Adds a corpse identification mechanic."
MODULE.Public = true
lia.config.add("IdentificationTime", "Identification Time", 5, nil, {
    desc = "The time (in seconds) required to identify a corpse.",
    category = "Identification",
    type = "Int",
    min = 1,
    max = 60
})

lia.config.add("CorpseMessageFont", "Corpse Message Font", "PoppinsMedium", function() if not CLIENT then return end hook.Run("RefreshFonts") end, {
    desc = "Font used for the identify-corpse 3D2D display",
    category = "Fonts",
    type = "Table",
    options = CLIENT and lia.font.getAvailableFonts() or {"PoppinsMedium"}
})