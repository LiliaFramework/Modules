local networkStrings = {
    "EditDetailedDescriptions",
    "OpenDetailedDescriptions",
    "SetDetailedDescriptions"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
