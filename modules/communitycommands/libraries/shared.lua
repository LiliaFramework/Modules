function MODULE:InitializedModules()
    for k, v in pairs(self.URLs) do
        lia.command.add(k, {
            adminOnly = false,
            syntax = "",
            onRun = function(client)
                if v ~= "" then
                    client:SendLua("gui.OpenURL('" .. v .. "')")
                else
                    client:notifyLocalized("notConfig")
                end
            end
        })
    end
end
