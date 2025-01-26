local isDownTime = false
function MODULE:PlayerLoadedChar()
    if not lia.config.get("EnableDownTime", false) then return end
    local playerCount = player.GetCount()
    local minimumPlayerCount = lia.config.get("RPMinimumPlayerCount", 5)
    if playerCount < minimumPlayerCount then
        if not isDownTime then isDownTime = true end
    else
        if isDownTime then
            for _, ply in player.Iterator() do
                ply:ChatPrint(L("DowntimeOver"))
            end

            isDownTime = false
        end
    end
end
