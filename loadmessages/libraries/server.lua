function MODULE:PlayerLoadedChar(client)
    local data = self.FactionMessages[client:Team()]
    if data then ClientAddText(client, unpack(data)) end
end