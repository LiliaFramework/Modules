function MODULE:HandleCommunityURL(client, command)
    local commandTable = self.URLs[command]
    if not commandTable then
        client:notifyLocalized("invalidCommand")
        return
    end

    net.Start("OpenCommunityURL")
    net.WriteString(command)
    net.WriteString(commandTable.URL)
    net.WriteBool(commandTable.shouldOpenIngame)
    net.Send(client)
end

local networkStrings = {"OpenCommunityURL",}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
