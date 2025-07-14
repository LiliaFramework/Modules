MODULE.name = "Chat Messages"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.08
MODULE.desc = "Periodically sends automated advert messages to chat at a configurable interval."
MODULE.Public = true
lia.config.add("ChatMessagesInterval", "Chat Messages Interval", 300, nil, {
    desc = "Time interval (in seconds) between each automatic chat message.",
    category = "Chat",
    type = "Int",
    min = 10,
    max = 3600
})

MODULE.Features = {"Adds periodic server adverts to chat", "Adds interval control via ChatMessagesInterval", "Adds localized message support", "Adds rotating tips for new players", "Adds toggle to disable adverts per user"}
