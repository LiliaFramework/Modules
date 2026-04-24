local playerMeta = FindMetaTable("Player")
function playerMeta:forceSequence(sequenceName, callback, time, noFreeze)
    hook.Run("OnPlayerEnterSequence", self, sequenceName, callback, time, noFreeze)
    if not sequenceName then
        net.Start("liaSeqSet")
        net.WriteEntity(self)
        net.WriteBool(false)
        net.Broadcast()
        return
    end

    local seqId = self:LookupSequence(sequenceName)
    if seqId and seqId > 0 then
        local duration = time or self:SequenceDuration(seqId)
        if isfunction(callback) then
            self.liaSeqCallback = callback
        else
            self.liaSeqCallback = nil
        end

        self.liaForceSeq = seqId
        if not noFreeze then self:SetMoveType(MOVETYPE_NONE) end
        if duration > 0 then timer.Create("liaSeq" .. self:EntIndex(), duration, 1, function() if IsValid(self) then self:leaveSequence() end end) end
        net.Start("liaSeqSet")
        net.WriteEntity(self)
        net.WriteBool(true)
        net.WriteInt(seqId, 16)
        net.Broadcast()
        return duration
    end
    return false
end

function playerMeta:leaveSequence()
    hook.Run("OnPlayerLeaveSequence", self)
    net.Start("liaSeqSet")
    net.WriteEntity(self)
    net.WriteBool(false)
    net.Broadcast()
    self:SetMoveType(MOVETYPE_WALK)
    self.liaForceSeq = nil
    if isfunction(self.liaSeqCallback) then self.liaSeqCallback() end
    self.liaSeqCallback = nil
end

function playerMeta:isWepRaised()
    local weapon = self:GetActiveWeapon()
    local override = hook.Run("ShouldWeaponBeRaised", self, weapon)
    if override ~= nil then return override end
    if IsValid(weapon) then
        if weapon.IsAlwaysRaised or weapon.AlwaysRaised or ALWAYS_RAISED and ALWAYS_RAISED[weapon:GetClass()] then
            return true
        elseif weapon.IsAlwaysLowered or weapon.NeverRaised then
            return false
        end
    end

    if self:getNetVar("restricted") then return false end
    if lia.config.get("wepAlwaysRaised", false) then return true end
    local raised = self:getNetVar("wepRaised")
    if raised ~= nil then return raised end
    raised = self:getNetVar("raised")
    if raised ~= nil then return raised end
    return false
end
