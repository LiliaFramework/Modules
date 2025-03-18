﻿function MODULE:InitializedModules()
    for commandName, data in pairs(self.URLs) do
        local url = data.URL
        lia.command.add(commandName, {
            adminOnly = false,
            syntax = "",
            onRun = function(client)
                if SERVER then
                    if url and url ~= "" then
                        self:HandleCommunityURL(client, commandName)
                    else
                        client:notifyLocalized("notConfig")
                    end
                end
            end
        })
    end
end
