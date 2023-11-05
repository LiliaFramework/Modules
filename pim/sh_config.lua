----------------------------------------------------------------------------------------------
lia.config.MaxInteractionDistance = 250 * 250
----------------------------------------------------------------------------------------------
lia.config.CarSearchRadius = 150
----------------------------------------------------------------------------------------------
timer.Simple(
    2,
    function()
        PIM:AddOption(
            "Give Money",
            {
                shouldShow = function(client, target) return client:getChar():getMoney() > 0 end,
                serverRun = false,
                onRun = function(client, target)
                    if not target:IsPlayer() then return end
                    local frame = vgui.Create("WolfFrame")
                    frame:SetSize(600, 250)
                    frame:Center()
                    frame:MakePopup()
                    frame:SetTitle("Enter amount")
                    frame:ShowCloseButton(false)
                    frame.te = frame:Add("DTextEntry")
                    frame.te:SetSize(frame:GetWide() * 0.6, 30)
                    frame.te:SetNumeric(true)
                    frame.te:Center()
                    frame.te:RequestFocus()
                    function frame.te:OnEnter()
                        local val = tonumber(frame.te:GetText())
                        if val == 0 then
                            client:notify("You need to insert a value bigger than 0.", NOT_ERROR)
                            return
                        end

                        if val < 0 then
                            client:notify("What are you trying to do? >:|", NOT_ERROR)
                            return
                        end

                        if math.modf(val) > 0 then val = math.ceil(val) end
                        if not client:getChar():hasMoney(val) then
                            client:notify("You don't have enough money", NOT_ERROR)
                            return
                        end

                        netstream.Start("transferMoneyFromP2P", val, target)
                        frame:Close()
                    end

                    frame.ok = frame:Add("DButton")
                    frame.ok:SetSize(150, 30)
                    frame.ok:CenterHorizontal()
                    frame.ok:CenterVertical(0.7)
                    frame.ok:SetText("Give Money")
                    frame.ok:SetTextColor(color_white)
                    frame.ok:SetFont("WB_Small")
                    frame.ok.DoClick = frame.te.OnEnter
                    function frame.ok:Paint(w, h)
                        draw.RoundedBox(0, 0, 0, w, h, BC_NEUTRAL)
                    end
                end
            }
        )

        ----------------------------------------------------------------------------------------------
        PIM:AddOption(
            "Open Detailed Description",
            {
                runServer = true,
                shouldShow = function(client, target) return hook.Run("IsValidTarget", target) end,
                onRun = function(client, target)
                    if SERVER then
                        net.Start("OpenDetailedDescriptions")
                        net.WriteEntity(target)
                        net.WriteString(target:getChar():getData("textDetDescData", nil) or "No detailed description found.")
                        net.WriteString(target:getChar():getData("textDetDescDataURL", nil) or "No detailed description found.")
                        net.Send(client)
                    end
                end
            }
        )

        ----------------------------------------------------------------------------------------------
        PIM:AddOption(
            "Allow This Player To Recognize You",
            {
                runServer = false,
                shouldShow = function(client, target)
                    local ourChar = client:getChar()
                    local tarCharID = target:getChar():getID()
                    return not hook.Run("IsCharRecognized", ourChar, tarCharID)
                end,
                onRun = function(client, target) if CLIENT then netstream.Start("rgnDirect", target) end end
            }
        )

        ----------------------------------------------------------------------------------------------
        PIM:AddOption(
            "Allow This Player To Recognize You With A Fake Name",
            {
                runServer = false,
                shouldShow = function(client, target)
                    local ourChar = client:getChar()
                    local tarCharID = target:getChar():getID()
                    return not hook.Run("IsCharRecognized", ourChar, tarCharID)
                end,
                onRun = function(client, target) if CLIENT then Derma_StringRequest("Allow those in whispering range to recognize you by a fake name.", "Enter a fake name to display to other players in range.", default or "", function(text) if text then netstream.Start("rgnDirect", target, text) end end) end end
            }
        )
    end
)
----------------------------------------------------------------------------------------------
