local networkStrings = {
    "RestartDisplay"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
