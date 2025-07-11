﻿net.Receive("TriggerCinematic", function(_, client)
    if not client:hasPrivilege("Commands - Use Cinematic Menu") then return end
    net.Start("TriggerCinematic")
    net.WriteString(net.ReadString())
    net.WriteString(net.ReadString())
    net.WriteUInt(net.ReadUInt(6), 6)
    net.WriteBool(net.ReadBool())
    net.WriteBool(net.ReadBool())
    net.WriteColor(net.ReadColor())
    net.Broadcast()
end)

local networkStrings = {"OpenCinematicMenu", "TriggerCinematic",}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
