local networkStrings = {
    "OpenCommunityURL"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
