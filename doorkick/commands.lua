local MODULE = MODULE
lia.command.add("doorkick", {
    adminOnly = false,
    desc = "doorkickCommandDesc",
    onRun = function(client)
        local ent = client:GetEyeTraceNoCursor().Entity
        if IsValid(ent) and ent:isDoor() and ent:getNetVar("disabled", false) then
            client:notifyLocalized("doorKickDisabled")
            hook.Run("DoorKickFailed", client, ent, "disabled")
            return
        end

        if table.HasValue(MODULE.KickDoorBlacklistedFactions, client:Team()) then
            client:notifyLocalized("doorKickTooWeak")
            hook.Run("DoorKickFailed", client, ent, "weak")
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
                    hook.Run("DoorKickStarted", client, ent)
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
                            lia.log.add(client, "doorkick", ent)
                            hook.Run("DoorKickedOpen", client, ent)
                        end
                    end)
                else
                    client:notifyLocalized("doorKickCannotKick")
                    hook.Run("DoorKickFailed", client, ent, "cannotKick")
                end
            elseif dist <= 60 then
                client:notifyLocalized("doorKickTooClose")
                hook.Run("DoorKickFailed", client, ent, "tooClose")
            else
                client:notifyLocalized("doorKickTooFar")
                hook.Run("DoorKickFailed", client, ent, "tooFar")
            end
        else
            client:notifyLocalized("doorKickInvalid")
            hook.Run("DoorKickFailed", client, ent, "invalid")
        end
    end
})