local networkStrings = {
    "GMTPDelete",
    "GMTPMove",
    "GMTPNewPoint",
    "GMTPUpdateEffect",
    "GMTPUpdateName",
    "GMTPUpdateSound",
    "gmTPMenu",
    "gmTPNewName"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
