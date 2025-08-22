local networkStrings = {
    "searchExit",
    "searchPly"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
