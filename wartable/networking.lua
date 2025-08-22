local networkStrings = {
    "ClearWarTable",
    "PlaceWarTableMarker",
    "RemoveWarTableMarker",
    "SetWarTableMap",
    "UseWarTable"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
