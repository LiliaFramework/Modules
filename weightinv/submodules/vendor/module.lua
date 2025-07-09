﻿MODULE.name = "Vendors"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.2"
MODULE.desc = "Adds NPC vendors that can sell things."
MODULE.CAMIPrivileges = {

    {
        Name = "Staff Permissions - Can Edit Vendors",
        MinAccess = "admin",
    },
}

lia.config.add("vendorDefaultMoney", "Default Vendor Money", 500, nil, {
    desc = "Sets the default amount of money a vendor starts with",
    category = "Vendors",
    type = "Int",
    min = 0,
    max = 100000})
