MODULE.name = "Raised Weapons"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.09
MODULE.desc = "Automatically lowers weapons when sprinting and raises them again after a short delay."
MODULE.Public = true
lia.config.add("WeaponRaiseSpeed", "Weapon Raise Speed", 1, nil, {
    desc = "Delay (in seconds) before raising the weapon after switching or reloading.",
    category = "Weapons",
    type = "Float",
    min = 0.1,
    max = 5
})

MODULE.Features = {"Adds auto-lowering of weapons when running", "Adds a raise delay set by WeaponRaiseSpeed", "Adds prevention of accidental fire", "Adds a toggle to keep weapons lowered", "Adds compatibility with melee weapons"}
