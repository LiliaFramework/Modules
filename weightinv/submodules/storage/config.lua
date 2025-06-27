MODULE.Vehicles = MODULE.Vehicles or {}
MODULE.StorageDefinitions = {
    ["models/props_junk/wood_crate001a.mdl"] = {
        name = "Wood Crate",
        desc = "A crate made out of wood.",
        invType = "WeightInv",
        weight = 16
    },
    ["models/props_c17/lockers001a.mdl"] = {
        name = "Locker",
        desc = "A white locker.",
        invType = "WeightInv",
        weight = 24
    },
    ["models/props_wasteland/controlroom_storagecloset001a.mdl"] = {
        name = "Metal Closet",
        desc = "A green storage closet.",
        invType = "WeightInv",
        weight = 35
    },
    ["models/props_wasteland/controlroom_filecabinet002a.mdl"] = {
        name = "File Cabinet",
        desc = "A metal file cabinet.",
        invType = "WeightInv",
        weight = 18
    },
    ["models/props_c17/furniturefridge001a.mdl"] = {
        name = "Refrigerator",
        desc = "A metal box to keep food in.",
        invType = "WeightInv",
        weight = 12
    },
    ["models/props_wasteland/kitchen_fridge001a.mdl"] = {
        name = "Large Refrigerator",
        desc = "A large metal box to keep even more food in.",
        invType = "WeightInv",
        weight = 20
    },
    ["models/props_junk/trashbin01a.mdl"] = {
        name = "Trash Bin",
        desc = "A container for junk.",
        invType = "WeightInv",
        weight = 6
    },
    ["models/items/ammocrate_smg1.mdl"] = {
        name = "Ammo Crate",
        desc = "A heavy crate for storing ammunition.",
        invType = "WeightInv",
        weight = 30,
        onOpen = function(entity)
            entity:ResetSequence("Close")
            timer.Create("CloseLid" .. entity:EntIndex(), 2, 1, function() if IsValid(entity) then entity:ResetSequence("Open") end end)
        end
    },
    vehicle = {
        name = "Trunk",
        desc = "A car's trunk.",
        invType = "WeightInv",
        weight = 15
    }
}