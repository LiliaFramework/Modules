local DiscordWebhook = ""
local function installed(name)
    local fmt = "%s_%s"
    local suffix = "win64"
    if file.Exists(string.format(fmt, name, suffix), "GAME") then return true end
    if jit.versionnum ~= 20004 and jit.arch == "x86" and system.IsLinux() then return file.Exists(string.format(fmt, name, "linux32"), "GAME") end
    return false
end

if installed("chttp") then
    print("chttp is installed")
    function MODULE:OnServerLog(_, _, logString)
        if DiscordWebhook == "" then return end
        chttp.request({
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
    end
else
    print("Discord Relay won't work until it is installed.")
    print("Install it at https://github.com/timschumi/gmod-chttp")
end