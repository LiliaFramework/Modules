local networkStrings = {
    "BodygrouperMenu",
    "BodygrouperMenuClose",
    "BodygrouperMenuCloseClientside"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
