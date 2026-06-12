MODULE.name = "Raise Weapons"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.desc = "Adds raised and lowered weapon states."
lia.config.add("wepAlwaysRaised", "Weapons Always Raised", false, nil, {
    desc = "Whether lowered/passive weapon states should be disabled.",
    category = "animations",
    type = "Boolean"
})

lia.config.add("wepToggleTime", "Weapon Toggle Time", 1, nil, {
    desc = "How long raising or holstering a weapon takes.",
    category = "animations",
    type = "Float",
    min = 0,
    max = 10
})
