MODULE.name = "Bodygrouper"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.9"
MODULE.desc = "Adds a customizable bodygroup closet entity that lets players adjust their model bodygroups through a menu."
MODULE.Public = true
lia.config.add("BodyGrouperModel", "Body Grouper Model", "models/props_c17/FurnitureDresser001a.mdl", nil, {
    desc = "Sets the model for the body grouper.",
    category = "Gameplay",
    type = "Generic"
})

MODULE.Features = {"Adds a spawnable closet entity for editing bodygroups", "Adds the ability to customize its model via BodyGrouperModel", "Adds menu access that requires proximity or privilege", "Adds an admin command to view another player's bodygroups", "Adds a networked menu for editing bodygroups",}
