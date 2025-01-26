MODULE.HospitalLocations = {Vector(-6175.214355, 9022.834961, 112.811897),}
lia.config.add("HospitalsEnabled", "Enable Hospitals", false, nil, {
    desc = "Enables or disables hospital respawn functionality.",
    category = "Death",
    type = "Boolean"
})

lia.config.add("LoseMoneyOnDeath", "Lose Money On Death", false, nil, {
    desc = "Determines if players lose money upon death.",
    category = "Death",
    type = "Boolean"
})

lia.config.add("DeathMoneyLoss", "Death Money Loss Percentage", 0.05, nil, {
    desc = "Percentage of money lost upon death.",
    category = "Death",
    type = "Float",
    min = 0,
    max = 1
})
