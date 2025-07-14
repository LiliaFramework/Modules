local DiscordWebhook = ""
if util.IsBinaryModuleInstalled("chttp") then
    require("chttp")
    function MODULE:OnServerLog(_, _, logString)
        if DiscordWebhook == "" then return end
        hook.Run("DiscordRelaySend", logString)
        CHTTP({
            url = DiscordWebhook,
            method = "POST",
            headers = {
                ["Content-Type"] = "application/json"
            },
            body = util.TableToJSON({
                content = logString,
                username = "Lilia Logger"
            })
        })
        hook.Run("DiscordRelayed", logString)
    end
else
    print(L("relayCHTTPMissing"))
    print(L("relayInstallPrompt"))
    hook.Run("DiscordRelayUnavailable")
end
