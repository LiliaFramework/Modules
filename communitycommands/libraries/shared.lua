function MODULE:InitializedModules()
    for commandName, data in pairs(self.URLs) do
        local url = data.URL
        lia.command.add(commandName, {
            adminOnly = false,
            desc = L("urlCommandDesc", commandName),
            onRun = function(client)
                if SERVER then
                    if url and url ~= "" then
                        self:HandleCommunityURL(client, commandName)
                    else
                        client:notifyLocalized("urlNotConfig")
                    end
                end
            end
        })
    end
end