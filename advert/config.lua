lia.config.add("AdvertPrice", "advertPrice", 10, nil, {
    desc = "advertPriceDesc",
    category = "advertisements",
    type = "Int",
    min = 1,
    max = 1000
})

lia.config.add("AdvertCooldown", "advertCooldown", 20, nil, {
    desc = "advertCooldownDesc",
    category = "advertisements",
    type = "Int",
    min = 1,
    max = 3600
})