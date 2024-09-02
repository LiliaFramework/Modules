local isDownTime = false
function MODULE:PlayerLoadedChar()
    if not self.EnableDownTime then return end
    local playerCount = player.GetCount()
    if playerCount < self.RPMinimumPlayerCount then
        if not isDownTime then isDownTime = true end
    else
        if isDownTime then
            lia.util.notify(L("DowntimeOver"), player.GetAll())
            isDownTime = false
        end
    end
end
