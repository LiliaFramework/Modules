local DiscordWebhook = ""

-- Configuration for different log types
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

-- Force HTTP mode (set to true to always use HTTP instead of CHTTP)
local ForceHTTPMode = false

-- Helper function to send Discord webhook
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
        -- Use HTTP (either forced or as fallback)
        local payload = util.TableToJSON({
            embeds = {embed},
            username = "Lilia Logger"
        })
        
        -- Use HTTP
        http.Post(DiscordWebhook, {
            payload = payload
        }, function(body, length, headers, code)
            -- Success callback
        end, function(err)
            -- Error callback - log the error
            print("[Discord Relay] HTTP failed: " .. tostring(err))
        end)
        
        -- Warn about HTTP unreliability if not forced
        if not ForceHTTPMode and util.IsBinaryModuleInstalled("chttp") then
            print("[Discord Relay] WARNING: CHTTP not available, using HTTP fallback. This method is unreliable and may cause delays or failures.")
            print("[Discord Relay] Install CHTTP at https://github.com/timschumi/gmod-chttp for reliable Discord webhook delivery.")
        elseif ForceHTTPMode then
            print("[Discord Relay] INFO: Using HTTP mode as configured.")
        end
    end
end

-- Helper function to create embed
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
    
    if fields then
        embed.fields = fields
    end
    
    return embed
end

-- Helper function to get player info
local function GetPlayerInfo(ply)
    if not IsValid(ply) then return "Unknown Player" end
    return string.format("%s (%s)", ply:Nick(), ply:SteamID64())
end

-- Helper function to get admin info
local function GetAdminInfo(admin)
    if not IsValid(admin) then return "Console" end
    return string.format("%s (%s)", admin:Nick(), admin:SteamID64())
end

-- Warning System Logs
function MODULE:OnWarningIssued(admin, ply, reason, count, adminSteamID, targetSteamID)
    if not LogConfig.warnings.enabled then return end
    
    local embed = CreateEmbed(
        LogConfig.warnings.title,
        "A warning has been issued to a player",
        LogConfig.warnings.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end

function MODULE:OnWarningRemoved(admin, ply, warning, index)
    if not LogConfig.warnings.enabled then return end
    
    local embed = CreateEmbed(
        LogConfig.warnings.title,
        "A warning has been removed from a player",
        LogConfig.warnings.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end

-- Ticket System Logs
hook.Add("TicketSystemCreated", "DiscordRelayTicketCreated", function(requester, message)
    if not LogConfig.tickets.enabled then return end
    
    local embed = CreateEmbed(
        LogConfig.tickets.title,
        "A new help ticket has been created",
        LogConfig.tickets.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end)

hook.Add("TicketSystemClaim", "DiscordRelayTicketClaimed", function(admin, requester, message)
    if not LogConfig.tickets.enabled then return end
    
    local embed = CreateEmbed(
        LogConfig.tickets.title,
        "A help ticket has been claimed by staff",
        LogConfig.tickets.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end)

hook.Add("TicketSystemClose", "DiscordRelayTicketClosed", function(admin, requester, message)
    if not LogConfig.tickets.enabled then return end
    
    local embed = CreateEmbed(
        LogConfig.tickets.title,
        "A help ticket has been closed",
        LogConfig.tickets.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end)

-- Anti-Cheat System Logs
hook.Add("PlayerCheatDetected", "DiscordRelayCheatDetected", function(ply)
    if not LogConfig.cheats.enabled then return end
    
    local embed = CreateEmbed(
        LogConfig.cheats.title,
        "A player has been flagged by the anti-cheat system",
        LogConfig.cheats.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end)

hook.Add("OnCheaterCaught", "DiscordRelayCheaterCaught", function(ply)
    if not LogConfig.cheats.enabled then return end
    
    local embed = CreateEmbed(
        LogConfig.cheats.title,
        "A player has been confirmed as cheating",
        LogConfig.cheats.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end)

-- Chat System Logs
hook.Add("PostPlayerSay", "DiscordRelayChatLog", function(ply, msg, chatType)
    if not LogConfig.chat.enabled then return end
    
    -- Only log OOC chat
    if chatType ~= "ooc" then return end
    
    local embed = CreateEmbed(
        LogConfig.chat.title,
        "OOC chat message sent",
        LogConfig.chat.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end)

-- Flag System Logs
hook.Add("DonatorFlagsGiven", "DiscordRelayDonatorFlagsGiven", function(target, flags)
    if not LogConfig.flags.enabled then return end
    
    local embed = CreateEmbed(
        LogConfig.flags.title,
        "Donator flags have been given to a player",
        LogConfig.flags.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end)

hook.Add("DonatorFlagsGranted", "DiscordRelayDonatorFlagsGranted", function(client, group)
    if not LogConfig.flags.enabled then return end
    
    local embed = CreateEmbed(
        LogConfig.flags.title,
        "Donator flags have been granted to a player",
        LogConfig.flags.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end)

hook.Add("CharHasFlags", "DiscordRelayCharFlagsCheck", function(char, flags)
    if not LogConfig.flags.enabled then return end
    
    local embed = CreateEmbed(
        LogConfig.flags.title,
        "Character flags check performed",
        LogConfig.flags.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end)

hook.Add("OnCharLocalVarChanged", "DiscordRelayCharVarChanged", function(char, k, old, new)
    if not LogConfig.flags.enabled then return end
    
    -- Only log flag-related changes
    if k == "flags" then
        local embed = CreateEmbed(
            LogConfig.flags.title,
            "Character flags have been modified",
            LogConfig.flags.color,
            {
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
            }
        )
        
        SendDiscordWebhook(embed)
    end
end)

-- Vendor System Logs
hook.Add("VendorEdited", "DiscordRelayVendorEdited", function(vendor, key)
    if not LogConfig.vendors.enabled then return end
    
    local embed = CreateEmbed(
        LogConfig.vendors.title,
        "A vendor has been edited",
        LogConfig.vendors.color,
        {
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
        }
    )
    
    SendDiscordWebhook(embed)
end)

-- Legacy server log relay (kept for backward compatibility)
function MODULE:OnServerLog(_, _, logString)
    if DiscordWebhook == "" then return end
    hook.Run("DiscordRelaySend", logString)
    
    if util.IsBinaryModuleInstalled("chttp") then
        require("chttp")
        -- Send as simple text message for server logs using CHTTP
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
        -- Fallback to HTTP for server logs
        http.Post(DiscordWebhook, {
            payload = util.TableToJSON({
                content = logString,
                username = "Lilia Logger"
            })
        }, function(body, length, headers, code)
            -- Success callback
        end, function(err)
            -- Error callback - log the error
            print("[Discord Relay] HTTP fallback failed for server log: " .. tostring(err))
        end)
        
        -- Warn about HTTP unreliability for server logs
        print("[Discord Relay] WARNING: CHTTP not available for server logs, using HTTP fallback. This method is unreliable and may cause delays or failures.")
        print("[Discord Relay] Install CHTTP at https://github.com/timschumi/gmod-chttp for reliable Discord webhook delivery.")
    end

    hook.Run("DiscordRelayed", logString)
end

-- Check if CHTTP is available and warn if not
if not util.IsBinaryModuleInstalled("chttp") then
    print(L("relayCHTTPMissing"))
    print(L("relayInstallPrompt"))
    hook.Run("DiscordRelayUnavailable")
end

-- Configuration commands
concommand.Add("discordrelay_webhook", function(ply, cmd, args)
    if IsValid(ply) and not ply:IsSuperAdmin() then
        ply:ChatPrint("You need super admin access to use this command.")
        return
    end
    
    if #args < 1 then
        if IsValid(ply) then
            ply:ChatPrint("Usage: discordrelay_webhook <webhook_url>")
        else
            print("Usage: discordrelay_webhook <webhook_url>")
        end
        return
    end
    
    DiscordWebhook = args[1]
    if IsValid(ply) then
        ply:ChatPrint("Discord webhook URL updated successfully.")
    else
        print("Discord webhook URL updated successfully.")
    end
end, nil, "Set the Discord webhook URL for the relay system")

concommand.Add("discordrelay_toggle", function(ply, cmd, args)
    if IsValid(ply) and not ply:IsSuperAdmin() then
        ply:ChatPrint("You need super admin access to use this command.")
        return
    end
    
    if #args < 2 then
        if IsValid(ply) then
            ply:ChatPrint("Usage: discordrelay_toggle <log_type> <enabled>")
            ply:ChatPrint("Log types: warnings, tickets, cheats, chat, flags, vendors")
            ply:ChatPrint("Enabled: 1 for true, 0 for false")
        else
            print("Usage: discordrelay_toggle <log_type> <enabled>")
            print("Log types: warnings, tickets, cheats, chat, flags, vendors")
            print("Enabled: 1 for true, 0 for false")
        end
        return
    end
    
    local logType = args[1]:lower()
    local enabled = tonumber(args[2]) == 1
    
    if LogConfig[logType] then
        LogConfig[logType].enabled = enabled
        local status = enabled and "enabled" or "disabled"
        if IsValid(ply) then
            ply:ChatPrint(string.format("%s logging has been %s.", logType, status))
        else
            print(string.format("%s logging has been %s.", logType, status))
        end
    else
        if IsValid(ply) then
            ply:ChatPrint("Invalid log type. Available types: warnings, tickets, cheats, chat, flags, vendors")
        else
            print("Invalid log type. Available types: warnings, tickets, cheats, chat, flags, vendors")
        end
    end
end, nil, "Toggle specific log types on/off")