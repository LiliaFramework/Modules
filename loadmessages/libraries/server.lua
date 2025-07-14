function MODULE:PlayerLoadedChar(client)
    local data = self.FactionMessages[client:Team()]
    if data then
        ClientAddText(client, unpack(data))
        hook.Run("LoadMessageSent", client, data)
    end
end
