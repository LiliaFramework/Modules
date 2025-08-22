local networkStrings = {
    "mCompass_AddMarker",
    "mCompass_RemoveMarker"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
