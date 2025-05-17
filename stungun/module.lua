MODULE.name = "Stun Gun"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.1.1"
MODULE.Public = true
MODULE.desc = "An Stun Gun Reworked from CustomHQ"
MODULE.WorkshopContent = {"3432649835"}
lia.config.add("StunTime", "Stun Time", 4, nil, {
    desc = "Duration of the stun effect in seconds",
    category = "Weapon",
    type = "Float",
    min = 0,
    max = 30,
    decimals = 2
})

lia.config.add("MaxDist", "Taser Max Distance", 400, nil, {
    desc = "Maximum range of the taser in units",
    category = "Weapon",
    type = "Int",
    min = 0,
    max = 2000
})

lia.config.add("DrawPostProcess", "Enable Stun Post‐Processing", true, nil, {
    desc = "Toggle screen effects when stunned",
    category = "Visuals",
    type = "Boolean"
})

lia.config.add("Damage", "Over‐Stun Damage", 5, nil, {
    desc = "Damage dealt on over‐stun",
    category = "Weapon",
    type = "Int",
    min = 0,
    max = 100
})