local networkStrings = {
    "ciga",
    "cigaArm",
    "cigaMessage",
    "cigaTalking",
    "cigaTankColor"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
