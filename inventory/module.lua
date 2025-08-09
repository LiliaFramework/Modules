MODULE.name = "moduleWeightedInventoryName"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = 1.21
MODULE.desc = "moduleWeightedInventoryDesc"
MODULE.Public = true
MODULE.enabled = function()
    local path = debug.getinfo(1, "S").source:sub(2):gsub("\\", "/")
    local required = ("gamemodes/%s/preload/"):format(engine.ActiveGamemode())
    if not path:find(required, 1, true) then return false, ("Weight Inventory must be in '%s' (current path: '%s')"):format(required, path) end
    return true
end

MODULE.Dependencies = {
    {
        File = "weightinv.lua",
        Realm = "shared"
    }
}

MODULE.Features = {
    "Adds an inventory limited by item weight",
    "Adds a shared weightinv library file",
    "Adds a new inventory type",
    "Adds a drag-and-drop weight management UI"
}
MODULE.Privileges = {
    {
        Name = "Set Inventory Weight",
        MinAccess = "admin",
        Category = "Inventory",
    }
}
