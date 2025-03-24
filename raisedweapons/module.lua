MODULE.name = "Raised Weapons"
MODULE.author = "76561198312513285"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0"
MODULE.desc = "Adds a safety system that holsters sweps."
lia.config.add("WeaponRaiseSpeed", "Weapon Raise Speed", 1, nil, {
    desc = "Delay (in seconds) before raising the weapon after switching or reloading.",
    category = "Weapons",
    type = "Float",
    min = 0.1,
    max = 5
})
