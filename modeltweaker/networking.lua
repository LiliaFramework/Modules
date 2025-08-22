local networkStrings = {
    "SeeModelTable",
    "WardrobeChangeModel"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
