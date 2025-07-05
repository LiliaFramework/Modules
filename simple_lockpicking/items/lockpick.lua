ITEM.name = "Lockpick"
ITEM.desc = "A device used to bypass door locks."
ITEM.model = "models/weapons/w_crowbar.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.functions.Use = {
    onRun = function(item)
        if item.beingUsed then return false end
        local ply = item.player
        local target = ply:GetEyeTrace().Entity
        if not ply:getNetVar("restricted") and IsValid(target) or target:IsVehicle() and target:isLocked() then
            item.beingUsed = true
            local timerID = "Lockpicksnd" .. ply:SteamID()
            timer.Create(timerID, 1, 15, function()
                if not ply or not ply:getNetVar("isPicking") then
                    timer.Remove(timerID)
                else
                    local snd = {1, 3, 4}
                    ply:EmitSound("weapons/357/357_reload" .. tostring(snd[math.random(1, #snd)]) .. ".wav", 75, 100)
                end
            end)

            ply:setNetVar("isPicking", true)
            ply:setAction("Lockpicking", 15)
            ply:doStaredAction(target, function()
                item:remove()
                ply:EmitSound("doors/door_latch3.wav")
                target:Fire("unlock")
                lia.log.add(ply, "lockpick", target)
                if target:IsVehicle() and target.IsSimfphyscar then target.IsLocked = false end
                ply:setNetVar("isPicking")
                timer.Remove(timerID)
            end, 15, function()
                ply:setNetVar("isPicking")
                ply:setAction()
                item.beingUsed = false
                timer.Remove(timerID)
            end)
        else
            item.player:notifyLocalized("targetUnlocked")
        end
        return false
    end,
    onCanRun = function(item) return not IsValid(item.entity) end
}

function ITEM:onCanBeTransfered()
    return not self.beingUsed
end