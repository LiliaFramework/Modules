PIM:AddOption("Put in vehicle", {
    runServer = true,
    shouldShow = function(client, target)
        local es = ents.FindInSphere(client:GetPos(), 150)
        for _, v in pairs(es) do
            if simfphys and v:isSimfphysCar() then return IsHandcuffed(target) end
        end
        return false
    end,
    onRun = function(client, target)
        if not SERVER then return end
        local es = ents.FindInSphere(client:GetPos(), 150)
        for _, v in pairs(es) do
            if simfphys and v:isSimfphysCar() then
                local closestSeat = v:GetClosestSeat(target)
                if not closestSeat or IsValid(closestSeat:GetDriver()) then
                    for i = 1, table.Count(v.pSeat) do
                        if IsValid(v.pSeat[i]) then
                            local HasPassenger = IsValid(v.pSeat[i]:GetDriver())
                            if not HasPassenger then
                                target:SetNWBool("WasCuffed", true)
                                OnHandcuffRemove(target)
                                target:EnterVehicle(v.pSeat[i])
                                SetDrag(target, client, false)
                                break
                            end
                        end
                    end
                else
                    target:SetNWBool("WasCuffed", true)
                    OnHandcuffRemove(target)
                    target:EnterVehicle(closestSeat)
                    SetDrag(target, client, false)
                end
            end
        end
    end
})

PIM:AddOption("Remove Cuffed Passengers", {
    runServer = true,
    shouldShow = function(client)
        for _, v in pairs(ents.FindInSphere(client:GetPos(), 150)) do
            if v:IsPlayer() and v:InVehicle() and IsHandcuffed(v) then return true end
        end
    end,
    onRun = function(_, target)
        if not SERVER then return end
        for i = 2, #target.pSeat do
            local driver = target.pSeat[i]:GetDriver()
            if IsValid(driver) and IsHandcuffed(driver) then driver:ExitVehicle() end
        end
    end
})

PIM:AddOption("Tie", {
    runServer = true,
    shouldShow = function(client, target) return client:getChar():getInv():hasItem("tie") and (IsValid(target) and not IsHandcuffed(target)) end,
    onRun = function(client, target)
        if not SERVER then return end
        local item = client:getChar():getInv():getFirstItemOfType("tie")
        if target:isStaffOnDuty() then
            target:notifyLocalized("staffRestrained", client:Name())
            client:notifyLocalized("cantRestrainStaff")
            return false
        end

        target:setAction("@beingTied", 3)
        client:setAction("@tying", 3)
        client:doStaredAction(target, function()
            HandcuffPlayer(target)
            item:remove()
        end, 3, function()
            client:stopAction()
            target:stopAction()
        end)
    end
})

PIM:AddOption("UnTie", {
    runServer = true,
    shouldShow = function(_, target) return IsHandcuffed(target) end,
    onRun = function(client, target)
        if not SERVER then return end
        target:setAction("@beingUntied", 3)
        client:setAction("@unTying", 3)
        client:doStaredAction(target, function() OnHandcuffRemove(target) end, 3, function()
            client:stopAction()
            target:stopAction()
        end)
    end
})