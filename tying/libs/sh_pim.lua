--------------------------------------------------------------------------------------------------------
if not PIM then return end
--------------------------------------------------------------------------------------------------------
PIM:AddOption(
    "Put in vehicle",
    {
        runServer = true,
        shouldShow = function(client, target)
            local es = ents.FindInSphere(client:GetPos(), lia.config.CarSearchRadius)
            for k, v in pairs(es) do
                if simfphys and simfphys.IsCar(v) then return IsHandcuffed(target) end
            end

            return false
        end,
        onRun = function(client, target)
            if not SERVER then return end
            local es = ents.FindInSphere(client:GetPos(), lia.config.CarSearchRadius)
            for k, v in pairs(es) do
                if simfphys.IsCar(v) then
                    if #v.pSeat <= 1 then
                        client:notify("Closest car doesn't have back seats", NOT_ERROR)

                        return
                    else
                        for i = 2, #v.pSeat do
                            if not IsValid(v.pSeat[i]:GetDriver()) then
                                target:EnterVehicle(v.pSeat[i])
                                SetDrag(target, nil)

                                return
                            end
                        end
                    end
                end
            end

            client:notify("No more space in closest vehicle", NOT_ERROR)
        end
    }
)

--------------------------------------------------------------------------------------------------------
PIM:AddOption(
    "Remove Cuffed Passengers",
    {
        runServer = true,
        shouldShow = function(client, target)
            for k, v in pairs(ents.FindInSphere(client:GetPos(), lia.config.CarSearchRadius)) do
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

--------------------------------------------------------------------------------------------------------
PIM:AddOption(
    "Tie",
    {
        runServer = true,
        shouldShow = function(client, target) return client:getChar():getInv():hasItem("tie") and (IsValid(target) and not IsHandcuffed(target)) end,
        onRun = function(client, target)
            if not SERVER then return end
            local item = client:getChar():getInv():getFirstItemOfType("tie")
            item:interact("Use", client)
        end
    }
)

--------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------