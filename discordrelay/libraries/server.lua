local DiscordWebhook = "https://discord.com/api/webhooks/YOUR_WEBHOOK_URL_HERE"
local LogConfig = {
    warnings = {
        enabled = true,
        color = 16776960, -- Yellow
        title = "Warning System"
    },
    tickets = {
        enabled = true,
        color = 3447003, -- Blue
        title = "Ticket System"
    },
    cheats = {
        enabled = true,
        color = 15158332, -- Red
        title = "Anti-Cheat System"
    },
    chat = {
        enabled = true,
        color = 3066993, -- Green
        title = "Chat System"
    },
    flags = {
        enabled = true,
        color = 10181046, -- Purple
        title = "Flag System"
    },
    vendors = {
        enabled = true,
        color = 15844367, -- Orange
        title = "Vendor System"
    }
}

local ForceHTTPMode = not util.IsBinaryModuleInstalled("chttp")
local function SendDiscordWebhook(embed)
    if DiscordWebhook == "" then return end
    if util.IsBinaryModuleInstalled("chttp") and not ForceHTTPMode then
        require("chttp")
        CHTTP({
            url = DiscordWebhook,
            method = "POST",
            headers = {
                ["Content-Type"] = "application/json"
            },
            body = util.TableToJSON({
                embeds = {embed},
                username = "Lilia Logger"
            })
        })
    else
        local payload = util.TableToJSON({
            embeds = {embed},
            username = "Lilia Logger"
        })

        http.Post(DiscordWebhook, {
            payload = payload
        }, function(body, length, headers, code) end, function(err) print("[Discord Relay] HTTP failed: " .. tostring(err)) end)

        if ForceHTTPMode then print("[Discord Relay] " .. L("relayHTTPMode")) end
    end

    hook.Run("DiscordRelayed", logString)
end

local function CreateEmbed(title, description, color, fields)
    local embed = {
        title = title,
        description = description,
        color = color or 7506394,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        footer = {
            text = "Lilia Discord Relay"
        }
    }

    if fields then embed.fields = fields end
    return embed
end

local function GetPlayerInfo(ply)
    if not IsValid(ply) then return "Unknown Player" end
    return string.format("%s (%s)", ply:Nick(), ply:SteamID64())
end

local function GetAdminInfo(admin)
    if not IsValid(admin) then return "Console" end
    return string.format("%s (%s)", admin:Nick(), admin:SteamID64())
end

function MODULE:OnWarningIssued(admin, ply, reason, count, adminSteamID, targetSteamID)
    if not LogConfig.warnings.enabled then return end
    local embed = CreateEmbed(LogConfig.warnings.title, "A warning has been issued to a player", LogConfig.warnings.color, {
        {
            name = "Admin",
            value = GetAdminInfo(admin),
            inline = true
        },
        {
            name = "Target Player",
            value = GetPlayerInfo(ply),
            inline = true
        },
        {
            name = "Reason",
            value = reason or "No reason specified",
            inline = false
        },
        {
            name = "Warning Count",
            value = tostring(count or 1),
            inline = true
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnWarningRemoved(admin, ply, warning, index)
    if not LogConfig.warnings.enabled then return end
    local embed = CreateEmbed(LogConfig.warnings.title, "A warning has been removed from a player", LogConfig.warnings.color, {
        {
            name = "Admin",
            value = GetAdminInfo(admin),
            inline = true
        },
        {
            name = "Target Player",
            value = GetPlayerInfo(ply),
            inline = true
        },
        {
            name = "Warning Index",
            value = tostring(index or "Unknown"),
            inline = true
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnTicketSystemCreated(requester, message)
    if not LogConfig.tickets.enabled then return end
    local embed = CreateEmbed(LogConfig.tickets.title, "A new help ticket has been created", LogConfig.tickets.color, {
        {
            name = "Requester",
            value = GetPlayerInfo(requester),
            inline = true
        },
        {
            name = "Message",
            value = message or "No message provided",
            inline = false
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnTicketSystemClaim(admin, requester, message)
    if not LogConfig.tickets.enabled then return end
    local embed = CreateEmbed(LogConfig.tickets.title, "A help ticket has been claimed by staff", LogConfig.tickets.color, {
        {
            name = "Staff Member",
            value = GetAdminInfo(admin),
            inline = true
        },
        {
            name = "Requester",
            value = GetPlayerInfo(requester),
            inline = true
        },
        {
            name = "Original Message",
            value = message or "No message provided",
            inline = false
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnTicketSystemClose(admin, requester, message)
    if not LogConfig.tickets.enabled then return end
    local embed = CreateEmbed(LogConfig.tickets.title, "A help ticket has been closed", LogConfig.tickets.color, {
        {
            name = "Staff Member",
            value = GetAdminInfo(admin),
            inline = true
        },
        {
            name = "Requester",
            value = GetPlayerInfo(requester),
            inline = true
        },
        {
            name = "Original Message",
            value = message or "No message provided",
            inline = false
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnPlayerCheatDetected(ply)
    if not LogConfig.cheats.enabled then return end
    local embed = CreateEmbed(LogConfig.cheats.title, "A player has been flagged by the anti-cheat system", LogConfig.cheats.color, {
        {
            name = "Player",
            value = GetPlayerInfo(ply),
            inline = true
        },
        {
            name = "Status",
            value = "Under Investigation",
            inline = true
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnCheaterCaught(ply)
    if not LogConfig.cheats.enabled then return end
    local embed = CreateEmbed(LogConfig.cheats.title, "A player has been confirmed as cheating", LogConfig.cheats.color, {
        {
            name = "Player",
            value = GetPlayerInfo(ply),
            inline = true
        },
        {
            name = "Status",
            value = "Confirmed Cheater",
            inline = true
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnPostPlayerSay(ply, msg, chatType)
    if not LogConfig.chat.enabled then return end
    if chatType ~= "ooc" then return end
    local embed = CreateEmbed(LogConfig.chat.title, "OOC chat message sent", LogConfig.chat.color, {
        {
            name = "Player",
            value = GetPlayerInfo(ply),
            inline = true
        },
        {
            name = "Message",
            value = msg or "No message",
            inline = false
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnDonatorFlagsGiven(target, flags)
    if not LogConfig.flags.enabled then return end
    local embed = CreateEmbed(LogConfig.flags.title, "Donator flags have been given to a player", LogConfig.flags.color, {
        {
            name = "Target Player",
            value = GetPlayerInfo(target),
            inline = true
        },
        {
            name = "Flags Given",
            value = flags or "No flags specified",
            inline = false
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnDonatorFlagsGranted(client, group)
    if not LogConfig.flags.enabled then return end
    local embed = CreateEmbed(LogConfig.flags.title, "Donator flags have been granted to a player", LogConfig.flags.color, {
        {
            name = "Player",
            value = GetPlayerInfo(client),
            inline = true
        },
        {
            name = "Group",
            value = group or "No group specified",
            inline = true
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnCharHasFlags(char, flags)
    if not LogConfig.flags.enabled then return end
    local embed = CreateEmbed(LogConfig.flags.title, "Character flags check performed", LogConfig.flags.color, {
        {
            name = "Character",
            value = tostring(char) or "Unknown",
            inline = true
        },
        {
            name = "Flags Checked",
            value = flags or "No flags specified",
            inline = false
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnCharLocalVarChanged(char, k, old, new)
    if not LogConfig.flags.enabled then return end
    if k == "flags" then
        local embed = CreateEmbed(LogConfig.flags.title, "Character flags have been modified", LogConfig.flags.color, {
            {
                name = "Character",
                value = tostring(char) or "Unknown",
                inline = true
            },
            {
                name = "Old Flags",
                value = tostring(old) or "None",
                inline = true
            },
            {
                name = "New Flags",
                value = tostring(new) or "None",
                inline = true
            }
        })

        SendDiscordWebhook(embed)
    end
end

function MODULE:OnVendorEdited(vendor, key)
    if not LogConfig.vendors.enabled then return end
    local embed = CreateEmbed(LogConfig.vendors.title, "A vendor has been edited", LogConfig.vendors.color, {
        {
            name = "Vendor",
            value = tostring(vendor) or "Unknown",
            inline = true
        },
        {
            name = "Edited Property",
            value = key or "Unknown",
            inline = true
        }
    })

    SendDiscordWebhook(embed)
end

function MODULE:OnServerLog(_, _, logString)
    if DiscordWebhook == "" then return end
    hook.Run("DiscordRelaySend", logString)
    if util.IsBinaryModuleInstalled("chttp") then
        require("chttp")
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
    else
        http.Post(DiscordWebhook, {
            payload = util.TableToJSON({
                content = logString,
                username = "Lilia Logger"
            })
        }, function(body, length, headers, code) end, function(err) print("[Discord Relay] " .. L("relayHTTPFailedLog") .. tostring(err)) end)

        if ForceHTTPMode then print("[Discord Relay] " .. L("relayHTTPMode")) end
    end

    hook.Run("DiscordRelayed", logString)
end

if ForceHTTPMode then
    print("[Discord Relay] CHTTP not detected, using HTTP mode automatically")
    print("[Discord Relay] " .. L("relayInstallPrompt"))
else
    print("[Discord Relay] CHTTP detected, using CHTTP mode")
end