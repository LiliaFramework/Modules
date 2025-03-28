﻿local MODULE = MODULE
MODULE.name = "Turning"
MODULE.author = "TankNut & bloodycop"
MODULE.discord = "bloodycop"
MODULE.version = "1.0"
MODULE.desc = "Adds support for playermodels playing turning animations."
MODULE.Public = true
MODULE.supportedModelClasses = {
    metrocop = true,
    overwatch = true,
    citizen_male = true,
    citizen_female = true
}

MODULE.activityWhitelist = {
    [ACT_MP_STAND_IDLE] = true,
    [ACT_MP_CROUCH_IDLE] = true
}
