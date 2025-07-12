MODULE.name = "Weight Inv"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.3"
MODULE.desc = "Implements a weight-based inventory that limits how much a character can carry."
MODULE.Public = true
MODULE.enabled = function()
    local path = debug.getinfo(1, "S").source:sub(2)
    if not path:find("/preload/") then return false, ("Module must be in a “preload” subfolder (current path: '%s')"):format(path) end
    return true
end

MODULE.Dependencies = {
    {
        File = "weightinv.lua",
        Realm = "shared"
    }
}

MODULE.Features = {"Adds an inventory limited by item weight", "Adds a shared weightinv library file", "Adds a new inventory type", "Adds a drag-and-drop weight management UI", "Adds support for backpacks to increase capacity",}