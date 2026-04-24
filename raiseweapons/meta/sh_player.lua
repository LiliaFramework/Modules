local playerMeta = FindMetaTable("Player")
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
    if lia.config.get("wepAlwaysRaised", true) then return true end
    local raised = self:getNetVar("raised")
    if raised ~= nil then return raised end
    raised = self:getNetVar("wepRaised")
    if raised ~= nil then return raised end
    return false
end

function playerMeta:WepRaised()
    return self:isWepRaised()
end

if SERVER then
    function playerMeta:setWepRaised(state)
        state = tobool(state)
        self:setNetVar("raised", state)
        self:setNetVar("wepRaised", state)
        local weapon = self:GetActiveWeapon()
        if IsValid(weapon) then
            weapon:SetNextPrimaryFire(CurTime() + 1)
            weapon:SetNextSecondaryFire(CurTime() + 1)
        end
    end

    function playerMeta:SetWepRaised(state)
        self:setWepRaised(state)
    end

    function playerMeta:toggleWepRaised()
        self:setWepRaised(not self:isWepRaised())
        local weapon = self:GetActiveWeapon()
        if not IsValid(weapon) then return end
        if self:isWepRaised() and isfunction(weapon.OnRaised) then
            weapon:OnRaised()
        elseif not self:isWepRaised() and isfunction(weapon.OnLowered) then
            weapon:OnLowered()
        end
    end

    function playerMeta:ToggleWepRaised()
        self:toggleWepRaised()
    end
end
