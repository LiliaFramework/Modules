MODULE.name = "Raised Weapons"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.3"
MODULE.desc = "Adds a safety system that holsters sweps."
MODULE.Public = true

lia.config.add("WeaponRaiseSpeed", "Weapon Raise Speed", 1, nil, {
    desc = "Delay (in seconds) before raising the weapon after switching or reloading.",
    category = "Weapons",
    type = "Float",
    min = 0.1,
    max = 5
})
