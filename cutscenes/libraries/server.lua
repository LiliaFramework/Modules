function MODULE:runCutscene(target, id)
    local recipients = target and {target} or player.GetAll()
    for _, ply in pairs(recipients) do
        net.Start("lia_cutscene")
        net.WriteString(id)
        net.Send(ply)
    end
end

local networkStrings = {"lia_cutscene"}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
