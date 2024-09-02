local MODULE = MODULE

lia.command.add("doorkick", {
    adminOnly = false,
    syntax = "",
    onRun = function(client)
        if table.HasValue(MODULE.KickDoorBlacklistedFactions, client:Team()) then
            client:notify(L("doorKickTooWeak"))
            return
        else
            if not client.isKickingDoor then
                local ent = client:GetEyeTraceNoCursor().Entity
                if IsValid(ent) and ent:isDoor() then
                    local dist = ent:GetPos():Distance(client:GetPos())
                    if dist > 60 and dist < 80 then
                        if not ent:getNetVar("faction") or ent:getNetVar("faction") ~= FACTION_STAFF then
                            client:Freeze(true)
                            client.isKickingDoor = true
                            net.Start("DoorKickView")
                            net.Send(client)
                            timer.Simple(0.5, function()
                                timer.Simple(0.9, function()
                                    if IsValid(client) then
                                        client:Freeze(false)
                                        client.isKickingDoor = false
                                    end
                                end)

                                if IsValid(ent) then
                                    ent:Fire("unlock")
                                    ent:Fire("open")
                                end
                            end)
                        else
                            client:notify(L("doorKickCannotKick"))
                        end
                    elseif dist < 60 then
                        client:notify(L("doorKickTooClose"))
                    elseif dist > 80 then
                        client:notify(L("doorKickTooFar"))
                    end
                else
                    client:notify(L("doorKickInvalid"))
                end
            end
        end
    end
})