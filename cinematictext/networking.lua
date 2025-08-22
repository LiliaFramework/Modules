local networkStrings = {
    "OpenCinematicMenu",
    "TriggerCinematic"
}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
