local MODULE = MODULE
lia.command.add("doorkick", {
    adminOnly = false,
    desc = L("doorkickCommandDesc"),
    onRun = function(client)
        local ent = client:GetEyeTraceNoCursor().Entity
        if IsValid(ent) and ent:isDoor() and ent:getNetVar("disabled", false) then
            client:notifyLocalized("doorKickDisabled")
            return
        end

        if table.HasValue(MODULE.KickDoorBlacklistedFactions, client:Team()) then
            client:notifyLocalized("doorKickTooWeak")
            return
        end

        if client.isKickingDoor then return end
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
                    client:notifyLocalized("doorKickCannotKick")
                end
            elseif dist <= 60 then
                client:notifyLocalized("doorKickTooClose")
            else
                client:notifyLocalized("doorKickTooFar")
            end
        else
            client:notifyLocalized("doorKickInvalid")
        end
    end
})
