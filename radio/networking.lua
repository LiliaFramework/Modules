local networkStrings = {
    "radioAdjust"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
