----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:PlayerBindPress(client, bind, pressed)
    bind = bind:lower()
    if IsHandcuffed(client) and (string.find(bind, "+speed") or string.find(bind, "gm_showhelp") or string.find(bind, "+jump") or string.find(bind, "+walk") or string.find(bind, "+use")) then return true end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:CheckValidSit(client, trace)
    if IsHandcuffed(client) then return false end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:CanDeleteChar(client, char)
    if IsHandcuffed(client) then return true end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:simfphysUse(ent, client)
    if IsHandcuffed(client) then return false end

    return true
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:PlayerSwitchWeapon(client, old, new)
    if IsHandcuffed(client) then return true end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:CanExitVehicle(veh, client)
    if IsHandcuffed(client) then return false end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:CanPlayerUseChar(client, char)
    if IsHandcuffed(client) then return false, "You're currently handcuffed." end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:PostPlayerLoadout(client)
    OnHandcuffRemove(client)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:PlayerUse(client, entity)
    if IsHandcuffed(client) then return false end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:ShouldWeaponBeRaised(client, weapon)
    if IsHandcuffed(client) then return false end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:VC_canEnterPassengerSeat(client, seat, veh)
    return not IsHandcuffed(client)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:CanPlayerInteractItem(client, action, item)
    if IsHandcuffed(client) then return false end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:PlayerUse(client, entity)
    if not IsHandcuffed(client) and (IsHandcuffed(entity) and entity:IsPlayer()) and not entity.liaBeingUnTied then
        entity.liaBeingUnTied = true
        entity:setAction("@beingUntied", 5)
        client:setAction("@unTying", 5)
        client:doStaredAction(
            entity,
            function()
                entity:setRestricted(false)
                entity.liaBeingUnTied = false
                client:EmitSound("npc/roller/blade_in.wav")
                entity:FreeTies()
            end,
            5,
            function()
                entity.liaBeingUnTied = false
                entity:setAction()
                client:setAction()
            end
        )
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:CanPlayerEnterVehicle(client)
    if IsHandcuffed(client) then return false end

    return true
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------