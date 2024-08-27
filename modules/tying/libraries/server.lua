function MODULE:PlayerBindPress(client, bind)
    bind = bind:lower()
    if IsHandcuffed(client) and (string.find(bind, "+speed") or string.find(bind, "gm_showhelp") or string.find(bind, "+jump") or string.find(bind, "+walk") or string.find(bind, "+use")) then return true end
end

function MODULE:CheckValidSit(client)
    if IsHandcuffed(client) then return false end
end

function MODULE:CanDeleteChar(client)
    if IsHandcuffed(client) then return true end
end

function MODULE:PlayerSwitchWeapon(client)
    if IsHandcuffed(client) then return true end
end

function MODULE:CanExitVehicle(_, client)
    if IsHandcuffed(client) then return false end
end

function MODULE:CanPlayerUseChar(client)
    if IsHandcuffed(client) then return false, "You're currently handcuffed." end
end

function MODULE:PostPlayerLoadout(client)
    OnHandcuffRemove(client)
end

function MODULE:ShouldWeaponBeRaised(client)
    if IsHandcuffed(client) then return false end
end

function MODULE:CanPlayerUseDoor(client)
    if IsHandcuffed(client) then return false end
end

function MODULE:CanPlayerInteractItem(client)
    if IsHandcuffed(client) then return false end
end

function MODULE:VC_canEnterPassengerSeat(client)
    return not IsHandcuffed(client)
end

function MODULE:CanPlayerInteractItem(client)
    if IsHandcuffed(client) then return false end
end

function MODULE:PlayerUse(client, entity)
    if IsHandcuffed(client) then return false end
    if (IsHandcuffed(entity) and entity:IsPlayer()) and not entity.liaBeingUnTied then
        entity.liaBeingUnTied = true
        entity:setAction("@beingUntied", 5)
        client:setAction("@unTying", 5)
        client:doStaredAction(entity, function()
            OnHandcuffRemove(entity)
            entity.liaBeingUnTied = false
            client:EmitSound("npc/roller/blade_in.wav")
        end, 5, function()
            entity.liaBeingUnTied = false
            entity:stopAction()
            client:stopAction()
        end)
    end
end

function MODULE:CanPlayerEnterVehicle(client)
    if IsHandcuffed(client) then return false end
    return true
end

function MODULE:PlayerLeaveVehicle(client)
    if client:GetNWBool("WasCuffed", false) then
        client:SetNWBool("WasCuffed", true)
        HandcuffPlayer(client)
    end
end

function HandcuffPlayer(target)
    target:SetRunSpeed(target:GetWalkSpeed())
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

    target:StartHandcuffAnim()
end

function MODULE:StartCommand(client, cmd)
    if IsHandcuffed(client) then
        cmd:RemoveKey(IN_SPEED)
        cmd:RemoveKey(IN_JUMP)
    end
end

function OnHandcuffRemove(target)
    target:setNetVar("restricted", false)
    hook.Run("ResetSubModuleCuffData", target)
    target:EndHandcuffAnim()
end

function MODULE:CanPlayerJoinClass(client)
    if IsHandcuffed(client) then
        client:notifyLocalized("cuffCannotChangeClass")
        return false
    end
end

function MODULE:KeyPress(client, key)
    if IsHandcuffed(client) and key == IN_DUCK then
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(29.4, 43, 0))
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(0.9, 85.7, 0))
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_L_Hand"), Angle(0, 0, 0))
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(0, 80.143, 0))
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(0, 0, 0))
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(-39.3, 85.4, -30.4))
    end
end

function MODULE:KeyRelease(client, key)
    if IsHandcuffed(client) and key == IN_DUCK then
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(20, 8.8, 0))
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(15, 0, 0))
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_L_Hand"), Angle(0, 0, 75))
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(-15, 0, 0))
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(0, 0, -75))
        client:ManipulateBoneAngles(client:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(-20, 16.6, 0))
    end
end