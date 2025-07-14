net.Receive("TriggerCinematic", function(_, client)
    if not client:hasPrivilege("Commands - Use Cinematic Menu") then return end
    local text = net.ReadString()
    local bigText = net.ReadString()
    local duration = net.ReadUInt(6)
    local blackBars = net.ReadBool()
    local music = net.ReadBool()
    local color = net.ReadColor()
    hook.Run("CinematicTriggered", client, text, bigText, duration, blackBars, music, color)
    net.Start("TriggerCinematic")
    net.WriteString(text)
    net.WriteString(bigText)
    net.WriteUInt(duration, 6)
    net.WriteBool(blackBars)
    net.WriteBool(music)
    net.WriteColor(color)
    net.Broadcast()
end)

local networkStrings = {"OpenCinematicMenu", "TriggerCinematic"}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
