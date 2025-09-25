lia.playerinteract.addInteraction("putInVehicle", {
    serverOnly = true,
    shouldShow = function(client, target)
        if not simfphys then return false end
        local es = ents.FindInSphere(client:GetPos(), 150)
        for _, v in pairs(es) do
            if v:isSimfphysCar() then return target:IsHandcuffed() end
        end
        return false
    end,
    onRun = function(client, target)
        if not SERVER then return end
        local es = ents.FindInSphere(client:GetPos(), 150)
        for _, v in pairs(es) do
            if v:isSimfphysCar() then
                local closestSeat = v:GetClosestSeat(target)
                if not closestSeat or IsValid(closestSeat:GetDriver()) then
                    for i = 1, table.Count(v.pSeat) do
                        if IsValid(v.pSeat[i]) then
                            local HasPassenger = IsValid(v.pSeat[i]:GetDriver())
                            if not HasPassenger then
                                target:setNetVar("WasCuffed", true)
                                OnHandcuffRemove(target)
                                target:EnterVehicle(v.pSeat[i])
                                SetDrag(target, client, false)
                                break
                            end
                        end
                    end
                else
                    target:setNetVar("WasCuffed", true)
                    OnHandcuffRemove(target)
                    target:EnterVehicle(closestSeat)
                    SetDrag(target, client, false)
                end
            end
        end
    end
})

lia.playerinteract.addInteraction("removeCuffedPassengers", {
    serverOnly = true,
    shouldShow = function(client)
        for _, v in pairs(ents.FindInSphere(client:GetPos(), 150)) do
            if v:IsPlayer() and v:InVehicle() and v:IsHandcuffed() then return true end
        end
    end,
    onRun = function(_, target)
        if not SERVER then return end
        for i = 2, #target.pSeat do
            local driver = target.pSeat[i]:GetDriver()
            if IsValid(driver) and driver:IsHandcuffed() then driver:ExitVehicle() end
        end
    end
})

lia.playerinteract.addInteraction("tie", {
    serverOnly = true,
    shouldShow = function(client, target) return client:getChar():getInv():hasItem("tie") and IsValid(target) and not target:IsHandcuffed() end,
    onRun = function(client, target)
        if not SERVER then return end
        local item = client:getChar():getInv():getFirstItemOfType("tie")
        if target:isStaffOnDuty() then
            target:notifyLocalized("staffRestrained", client:Name())
            client:notifyLocalized("cantRestrainStaff")
            return false
        end

        target:setAction(L("beingUntied"), 3)
        client:setAction(L("untying"), 3)
        client:doStaredAction(target, function()
            HandcuffPlayer(target)
            lia.log.add(client, "tie", target)
            item:remove()
        end, 3, function()
            client:stopAction()
            target:stopAction()
        end)
    end
})

lia.playerinteract.addInteraction("unTie", {
    serverOnly = true,
    shouldShow = function(_, target) return target:IsHandcuffed() end,
    onRun = function(client, target)
        if not SERVER then return end
        target:setAction(L("beingUntied"), 3)
        client:setAction(L("untying"), 3)
        client:doStaredAction(target, function()
            OnHandcuffRemove(target)
            lia.log.add(client, "untie", target)
        end, 3, function()
            client:stopAction()
            target:stopAction()
        end)
    end
})
