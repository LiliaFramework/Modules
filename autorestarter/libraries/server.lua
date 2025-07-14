local MODULE = MODULE
MODULE.nextRestart = MODULE.nextRestart or 0
local notified = {}
function MODULE:InitializedModules()
    self.nextRestart = os.time() + lia.config.get("RestartInterval")
    hook.Run("AutoRestartScheduled", self.nextRestart)
    timer.Remove("AutoRestarter_Timer")
    timer.Create("AutoRestarter_Timer", 1, 0, function()
        local now = os.time()
        if now >= self.nextRestart then
            self.nextRestart = now + lia.config.get("RestartInterval")
            hook.Run("AutoRestartScheduled", self.nextRestart)
            for _, ply in player.Iterator() do
                net.Start("RestartDisplay")
                net.WriteInt(self.nextRestart, 32)
                net.Send(ply)
                notified[ply:SteamID()] = false
            end
            hook.Run("AutoRestart", now)
            hook.Run("AutoRestartStarted", game.GetMap())
            game.ConsoleCommand("changelevel " .. game.GetMap() .. "\n")
        else
            local interval = lia.config.get("RestartInterval")
            local remaining = self.nextRestart - now
            if remaining <= interval * 0.25 then
                hook.Run("AutoRestartCountdown", remaining)
                for _, ply in player.Iterator() do
                    local id = ply:SteamID()
                    if not notified[id] then
                        net.Start("RestartDisplay")
                        net.WriteInt(self.nextRestart, 32)
                        net.Send(ply)
                        notified[id] = true
                    end
                end
            end
        end
    end)
end

function MODULE:OnReloaded()
    if not self.nextRestart or self.nextRestart == 0 then self.nextRestart = os.time() + lia.config.get("RestartInterval") end
    net.Start("RestartDisplay")
    net.WriteInt(self.nextRestart, 32)
    net.Broadcast()
end

function MODULE:PlayerInitialSpawn(client)
    if not self.nextRestart or self.nextRestart == 0 then self.nextRestart = os.time() + lia.config.get("RestartInterval") end
    notified[client:SteamID()] = false
    net.Start("RestartDisplay")
    net.WriteInt(self.nextRestart, 32)
    net.Send(client)
end

local networkStrings = {"RestartDisplay"}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end
