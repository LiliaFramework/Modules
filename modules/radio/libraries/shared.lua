local MODULE = MODULE
local find = {
    ["radio"] = true,
}

function MODULE:EndChatter(listener)
    timer.Simple(1, function()
        if not listener:IsValid() or not listener:Alive() or hook.Run("ShouldRadioBeep", listener) == false then return false end
        listener:EmitSound("npc/metropolice/vo/off" .. math.random(1, 3) .. ".wav", math.random(60, 70), math.random(80, 120))
    end)
end

lia.chat.register("radio", {
    format = "%s says in radio: \"%s\"",
    font = "liaRadioFont",
    onGetColor = function() return Color(100, 255, 50) end,
    onCanHear = function(speaker, listener)
        local dist = speaker:GetPos():Distance(listener:GetPos())
        local speakRange = ChatboxCore.ChatRange
        local listenerEnts = ents.FindInSphere(listener:GetPos(), speakRange)
        local listenerInv = listener:getChar():getInv()
        local freq = nil
        if not CURFREQ or CURFREQ == "" or not CURCHANNEL then return false end
        if dist <= speakRange then return true end
        if listenerInv then
            for _, v in pairs(listenerInv:getItems()) do
                if freq then break end
                for id, _ in pairs(find) do
                    if v.uniqueID == id and v:getData("enabled", false) then
                        if CURFREQ == v:getData("freq", "000.0") and CURCHANNEL == v:getData("channel", 1) then
                            MODULE:EndChatter(listener)
                            return true
                        end

                        break
                    end
                end
            end
        end

        if not freq then
            for _, v in ipairs(listenerEnts) do
                if freq then break end
                if v:GetClass() == "lia_item" then
                    local itemTable = v:getItemTable()
                    for id, far in pairs(find) do
                        if far and itemTable.uniqueID == id and v:getData("enabled", false) then
                            if CURFREQ == v:getData("freq", "000.0") and CURCHANNEL == v:getData("channel", 1) then
                                MODULE:EndChatter(listener)
                                return true
                            end
                        end
                    end
                end
            end
        end
        return false
    end,
    onCanSay = function(speaker)
        local schar = speaker:getChar()
        local speakRange = ChatboxCore.ChatRange
        local speakEnts = ents.FindInSphere(speaker:GetPos(), speakRange)
        local speakerInv = schar:getInv()
        local freq = nil
        local channel
        if speakerInv then
            for _, v in pairs(speakerInv:getItems()) do
                if freq then break end
                for id, _ in pairs(find) do
                    if v.uniqueID == id and v:getData("enabled", false) then
                        freq = v:getData("freq", "000.0")
                        channel = v:getData("channel", 1)
                        break
                    end
                end
            end
        end

        if not freq then
            for _, v in ipairs(speakEnts) do
                if freq then break end
                if v:GetClass() == "lia_item" then
                    local itemTable = v:getItemTable()
                    for id, far in pairs(find) do
                        if far and itemTable.uniqueID == id and v:getData("enabled", false) then
                            freq = v:getData("freq", "000.0")
                            channel = v:getData("channel", 1)
                            break
                        end
                    end
                end
            end
        end

        if freq then
            CURFREQ = freq
            if channel then CURCHANNEL = channel end
            speaker:EmitSound("npc/metropolice/vo/on" .. math.random(1, 2) .. ".wav", math.random(50, 60), math.random(80, 120))
        else
            speaker:notifyLocalized("radioNoRadioComm")
            return false
        end
    end,
    prefix = {"/r", "/radio"},
})
