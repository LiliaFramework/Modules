----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PIM:AddOption(
    "Put in vehicle",
    {
        runServer = true,
        shouldShow = function(client, target)
            local es = ents.FindInSphere(client:GetPos(), 150)
            for k, v in pairs(es) do
                if simfphys and simfphys.IsCar(v) then return IsHandcuffed(target) end
            end

            return false
        end,
        onRun = function(client, target)
            if not SERVER then return end
            local es = ents.FindInSphere(client:GetPos(), 150)
            for k, v in pairs(es) do
                if simfphys.IsCar(v) then
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
    }
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PIM:AddOption(
    "Remove Cuffed Passengers",
    {
        runServer = true,
        shouldShow = function(client, target)
            for k, v in pairs(ents.FindInSphere(client:GetPos(), 150)) do
                if v:IsPlayer() and v:InVehicle() and IsHandcuffed(v) then return true end
            end
        end,
        onRun = function(client, target)
            if not SERVER then return end
            for i = 2, #target.pSeat do
                local driver = target.pSeat[i]:GetDriver()
                if IsValid(driver) and IsHandcuffed(driver) then
                    driver:ExitVehicle()
                end
            end
        end
    }
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PIM:AddOption(
    "Tie",
    {
        runServer = true,
        shouldShow = function(client, target) return client:getChar():getInv():hasItem("tie") and (IsValid(target) and not IsHandcuffed(target)) end,
        onRun = function(client, target)
            if not SERVER then return end
            local item = client:getChar():getInv():getFirstItemOfType("tie")
            if target:Team() == FACTION_STAFF then
                target:notify("You were just attempted to be restrained by " .. client:Name() .. ".")
                client:notify("You can't tie a staff member!")

                return false
            end

            target:setAction("@beingTied", 3)
            client:setAction(
                "@tying",
                3,
                function()
                    HandcuffPlayer(target)
                    item:remove()
                end
            )
        end
    }
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PIM:AddOption(
    "UnTie",
    {
        runServer = true,
        shouldShow = function(client, target) return IsHandcuffed(target) end,
        onRun = function(client, target)
            if not SERVER then return end
            OnHandcuffRemove(target)
        end
    }
)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------