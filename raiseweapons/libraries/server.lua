local MODULE = MODULE
local function getToggleTimerName(client)
    return "liaToggleRaise" .. client:SteamID64()
end

local function clearPendingToggle(client)
    if not IsValid(client) then return end
    timer.Remove(getToggleTimerName(client))
    client.liaToggleRaisePending = nil
    client:setAction(false)
end

function MODULE:KeyPress(client, key)
    if key ~= IN_RELOAD or not IsValid(client) or not client.toggleWepRaised then return end
    if client.liaToggleRaisePending then return end
    local toggleTime = lia.config.get("wepToggleTime", 1)
    local text = client:isWepRaised() and "Holstering weapon..." or "Unholstering weapon..."
    client.liaToggleRaisePending = true
    client:setAction(text, toggleTime)
    timer.Create(getToggleTimerName(client), toggleTime, 1, function()
        if not IsValid(client) then return end
        client.liaToggleRaisePending = nil
        client:setAction(false)
        client:toggleWepRaised()
    end)
end

function MODULE:KeyRelease(client, key)
    if key ~= IN_RELOAD or not IsValid(client) or not client.liaToggleRaisePending then return end
    clearPendingToggle(client)
end

function MODULE:PlayerSwitchWeapon(client)
    if not IsValid(client) or not client.setWepRaised then return end
    clearPendingToggle(client)
    client:setWepRaised(false)
end

function MODULE:PlayerDeath(client)
    clearPendingToggle(client)
end
