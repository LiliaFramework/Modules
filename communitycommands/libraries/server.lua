function MODULE:HandleCommunityURL(client, command)
    local commandTable = self.URLs[command]
    if not commandTable then
        client:notifyLocalized("invalidCommand")
        return
    end

    hook.Run("CommunityURLRequest", client, command)
    net.Start("OpenCommunityURL")
    net.WriteString(command)
    net.WriteString(commandTable.URL)
    net.WriteBool(commandTable.shouldOpenIngame)
    net.Send(client)
end

