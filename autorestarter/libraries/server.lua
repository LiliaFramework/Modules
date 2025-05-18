local MODULE = MODULE
MODULE.nextRestart = MODULE.nextRestart or 0
function MODULE:InitializedModules()
    self.nextRestart = os.time() + lia.config.get("RestartInterval")
    if timer.Exists("AutoRestarter_Timer") then timer.Remove("AutoRestarter_Timer") end
    timer.Create("AutoRestarter_Timer", 1, 0, function()
        if os.time() >= self.nextRestart then
            self.nextRestart = os.time() + lia.config.get("RestartInterval")
            for _, ply in player.Iterator() do
                net.Start("RestartDisplay")
                net.WriteInt(self.nextRestart, 32)
                net.Send(ply)
            end

            game.ConsoleCommand("changelevel " .. game.GetMap() .. "\n")
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
    net.Start("RestartDisplay")
    net.WriteInt(self.nextRestart, 32)
    net.Send(client)
end