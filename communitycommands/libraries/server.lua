function MODULE:HandleCommunityURL(client, command)
    local commandTable = self.URLs[command]
    if not commandTable then
        client:notify("Unknown command.")
        return
    end

    net.Start("OpenCommunityURL")
    net.WriteString(command)
    net.WriteString(commandTable.URL)
    net.WriteBool(commandTable.shouldOpenIngame)
    net.Send(client)
end
