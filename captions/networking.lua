local networkStrings = {
    "EndCaption",
    "StartCaption"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
