﻿ITEM.name = "Radio"
ITEM.desc = "Radio to use to talk to other people"
ITEM.isRadio = true
ITEM.model = "models/danradio/w_radio.mdl"
ITEM.functions.sabotage = {
    name = L("sabotage"),
    icon = "icon16/disconnect.png",
    onRun = function(item)
        local client = item.player
        local entity = item.entity
        if not IsValid(entity) then return false end
        client:setAction("Breaking", 5, function()
            if IsValid(item.entity) then
                item:remove()
                lia.chat.send(client, "actions", L("radioBreakAction"), false)
                lia.item.spawn("broken_radio", client:getItemDropPos())
                hook.Run("OnRadioSabotaged", client, item)
            end
        end)
        return false
    end,
    onCanRun = function(item) return IsValid(item.entity) end
}

ITEM.functions.enable = {
    name = L("radioTurnOn"),
    icon = "icon16/connect.png",
    onRun = function(item)
        local client = item.player
        local items = client:getChar():getInv():getItems()
        client.RadioCount = client.RadioCount or {}
        for _, v in pairs(items) do
            if v.id ~= item.id and v.uniqueID == item.uniqueID and v:getData("enabled") then
                client:notifyLocalized("radioAlreadyEquipped")
                return false
            end
        end

        item:setData("enabled", true)
        client:EmitSound("buttons/combine_button1.wav", 50, 170)
        hook.Run("OnRadioEnabled", client, item)
        return false
    end,
    onCanRun = function(item)
        if item.entity then return false end
        if not item:getData("enabled") then return true end
        return false
    end
}

ITEM.functions.disable = {
    name = L("radioTurnOff"),
    icon = "icon16/disconnect.png",
    onRun = function(item)
        local client = item.player
        item:setData("enabled", false)
        client:EmitSound("buttons/combine_button1.wav", 50, 170)
        hook.Run("OnRadioDisabled", client, item)
        return false
    end,
    onCanRun = function(item)
        if item.entity then return false end
        if item:getData("enabled") then return true end
        return false
    end
}

ITEM.functions.changeFreq = {
    name = L("radioChangeFreq"),
    icon = "icon16/transmit_blue.png",
    onRun = function(item)
        net.Start("radioAdjust")
        net.WriteString(item:getData("freq", "000.0"))
        net.WriteUInt(item.id or 0, 32)
        net.Send(item.player)
        return false
    end,
    onCanRun = function(item)
        if item.entity then return false end
        if item:getData("enabled") then return true end
        return false
    end
}

function ITEM:getDesc()
    if not self.entity or not IsValid(self.entity) then
        return L("radioDescFormat", self:getData("enabled") and L("on") or L("off"), self:getData("freq", "000.0"))
    else
        return L("radioDescEntityFormat", self.entity:getData("enabled") and L("on") or L("off"), self.entity:getData("freq", "000.0"))
    end
end

if CLIENT then
    function ITEM:paintOver(item, w, h)
        if item:getData("enabled") then
            surface.SetDrawColor(110, 255, 110, 100)
        else
            surface.SetDrawColor(255, 110, 110, 100)
        end

        surface.DrawRect(w - 14, h - 14, 8, 8)
    end
end
