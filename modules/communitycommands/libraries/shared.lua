function MODULE:InitializedModules()
    for k, v in pairs(self.urls) do
        lia.command.add(k, {
            adminOnly = false,
            syntax = "",
            onRun = function(client)
                if v ~= "" then
                    client:SendLua("gui.OpenURL('" .. v .. "')")
                else
                    client:notify("This URL isn't configured")
                end
            end
        })
    end
end