MODULE.name = "Vendors"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 10004
MODULE.desc = "Creates NPC vendors with customizable inventories and starting money."
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
    max = 100000
})

MODULE.Features = {"Adds NPC vendors that sell items", "Adds editable inventory menus", "Adds configurable default money", "Adds transaction logs for purchases", "Adds vendor restock timers"}
