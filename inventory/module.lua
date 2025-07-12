MODULE.name = "Weight Inv"
MODULE.author = "Samael"
MODULE.discord = "@liliaplayer"
MODULE.version = "1.0.3"
MODULE.desc = "Adds a weight inventory type."
MODULE.Public = true
MODULE.enabled = function()
    local path = MODULE.folder
    if not path:find("/preload/") then return false, "Module must be located in a 'preload' subfolder (current path: '" .. path .. "')" end
    return true
end

MODULE.Dependencies = {
    {
        File = "weightinv.lua",
        Realm = "shared"
    },
}

MODULE.Features = {"Adds an inventory limited by item weight", "Adds a shared weightinv library file", "Adds a new inventory type",}