MODULE.HospitalLocations = {Vector(-6175.214355, 9022.834961, 112.811897)}
lia.config.add("HospitalsEnabled", "enableHospitals", false, nil, {
    desc = "enableHospitalsDesc",
    category = "death",
    type = "Boolean"
})

lia.config.add("LoseMoneyOnDeath", "loseMoneyOnDeath", false, nil, {
    desc = "loseMoneyOnDeathDesc",
    category = "death",
    type = "Boolean"
})

lia.config.add("DeathMoneyLoss", "deathMoneyLossPercentage", 0.05, nil, {
    desc = "deathMoneyLossPercentageDesc",
    category = "death",
    type = "Float",
    min = 0,
    max = 1
})