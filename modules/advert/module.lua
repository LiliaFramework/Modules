MODULE.name = "Advert"
MODULE.author = "76561198312513285"
MODULE.discord = "@liliaplayer"
MODULE.version = "Stock"
MODULE.desc = "Adds a Advert Command"
lia.config.add("AdvertPrice", "Advert Price", 10, nil, {
    desc = "The cost of sending an advertisement.",
    category = "Advertisements",
    type = "Int",
    min = 1,
    max = 1000
})

lia.config.add("AdvertCooldown", "Advert Cooldown", 20, nil, {
    desc = "The cooldown time (in seconds) between advertisements.",
    category = "Advertisements",
    type = "Int",
    min = 1,
    max = 3600
})
