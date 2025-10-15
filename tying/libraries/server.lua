function MODULE:CheckValidSit(client)
    if client:isHandcuffed() then return false end
end

function MODULE:CanDeleteChar(client)
    if client:isHandcuffed() then return true end
end

function MODULE:PlayerSwitchWeapon(client)
    if client:isHandcuffed() then return true end
end

function MODULE:CanExitVehicle(_, client)
    if client:isHandcuffed() then return false end
end

function MODULE:CanPlayerUseChar(client)
    if client:isHandcuffed() then return false, L("youAreTied") end
end

function MODULE:PostPlayerLoadout(client)
    OnHandcuffRemove(client)
end

function MODULE:ShouldWeaponBeRaised(client)
    if client:isHandcuffed() then return false end
end

function MODULE:CanPlayerUseDoor(client)
    if client:isHandcuffed() then return false end
end

function MODULE:CanPlayerInteractItem(client)
    if client:isHandcuffed() then return false end
end

function MODULE:VC_canEnterPassengerSeat(client)
    return not client:isHandcuffed()
end

function MODULE:CanPlayerInteractItem(client)
    if client:isHandcuffed() then return false end
end

function MODULE:PlayerUse(client, entity)
    if client:isHandcuffed() then return false end
    if entity:IsPlayer() and entity:isHandcuffed() and not entity.liaBeingUnTied then
        entity.liaBeingUnTied = true
        hook.Run("PlayerStartUnTying", client, entity)
        entity:setAction(L("beingUntied"), 5)
        client:setAction(L("untying"), 5)
        client:doStaredAction(entity, function()
            OnHandcuffRemove(entity)
            entity.liaBeingUnTied = false
            hook.Run("PlayerFinishUnTying", client, entity)
            client:EmitSound("npc/roller/blade_in.wav")
        end, 5, function()
            entity.liaBeingUnTied = false
            entity:stopAction()
            client:stopAction()
            hook.Run("PlayerUnTieAborted", client, entity)
        end)
    end
end

function MODULE:CanPlayerEnterVehicle(client)
    if client:isHandcuffed() then return false end
    return true
end

function MODULE:PlayerLeaveVehicle(client)
    if client:getNetVar("WasCuffed", false) then
        client:setNetVar("WasCuffed", true)
        handcuffPlayer(client)
    end
end

function handcuffPlayer(target)
    if not IsValid(target) then return end
    hook.Run("PlayerStartHandcuff", target)
    for _, v in pairs(target:getChar():getInv():getItems()) do
        if v.isWeapon and v:getData("equip") then v:setData("equip", nil) end
    end

    if target.carryWeapons then
        for _, weapon in pairs(target.carryWeapons) do
            target:StripWeapon(weapon:GetClass())
        end

        target.carryWeapons = {}
    end

    timer.Simple(.2, function()
        target:SelectWeapon("lia_keys")
        target:setNetVar("restricted", true)
    end)

    target:startHandcuffAnim()
    hook.Run("PlayerHandcuffed", target)
end

function OnHandcuffRemove(target)
    target:setNetVar("restricted", false)
    hook.Run("ResetSubModuleCuffData", target)
    target:endHandcuffAnim()
    hook.Run("PlayerUnhandcuffed", target)
end

function MODULE:CanPlayerJoinClass(client)
    if client:isHandcuffed() then
        client:notifyLocalized("cuffCannotChangeClass")
        return false
    end
end

lia.log.addType("tie", function(client, target)
    local name = IsValid(target) and target:Name() or "unknown"
    return L("tieLog", client:Name(), name)
end, "Player")

lia.log.addType("untie", function(client, target)
    local name = IsValid(target) and target:Name() or "unknown"
    return L("untieLog", client:Name(), name)
end, "Player")
