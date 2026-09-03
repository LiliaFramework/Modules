function MODULE:PlayerLoadedChar(client)
    local data = self.FactionMessages[client:Team()]
    if data then lia.util.addText(client, unpack(data)) end
end
