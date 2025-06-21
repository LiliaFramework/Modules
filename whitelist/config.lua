lia.config.add("WhitelistEnabled", "Enable or disable the Whitelist", false, nil, {
    desc = "Determines whether the whitelist feature is enabled on the server.",
    category = "Server",
    noNetworking = false,
    schemaOnly = false,
    isGlobal = false,
    type = "Boolean"
})

lia.config.add("BlacklistedEnabled", "Enable or disable the Blacklist", false, nil, {
    desc = "Determines whether the blacklist feature is enabled on the server.",
    category = "Server",
    noNetworking = false,
    schemaOnly = false,
    isGlobal = false,
    type = "Boolean"
})

MODULE.BlacklistedSteamID64 = {}
MODULE.WhitelistedSteamID64 = {"76561198312513285"}