function MODULE:PlayerLoadedChar(client)
    local data = self.FactionMessages[client:Team()]
    if data then
        hook.Run("PreLoadMessage", client, data)
        ClientAddText(client, unpack(data))
        hook.Run("LoadMessageSent", client, data)
        hook.Run("PostLoadMessage", client, data)
    else
        hook.Run("LoadMessageMissing", client)
    end
end