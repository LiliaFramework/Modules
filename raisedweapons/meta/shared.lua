local ShouldPrintMessage = false
local PermaRaisedWeapons = {
    ["weapon_physgun"] = true,
    ["gmod_tool"] = true,
}

local PermaRaisedBases = {
    ["tfa_gun_base"] = false,
    ["arccw_base"] = false,
    ["cw_base"] = false,
}

local playerMeta = FindMetaTable("Player")
function playerMeta:isWepRaised()
    local weapon = self:GetActiveWeapon()
    local override = hook.Run("ShouldWeaponBeRaised", self, weapon)
    if override ~= nil then return override end
    if IsValid(weapon) then
        local weaponClass = weapon:GetClass()
        local weaponBase = weapon.Base
        if PermaRaisedWeapons[weaponClass] or PermaRaisedBases[weaponBase] or weapon.IsAlwaysRaised or weapon.AlwaysRaised then
            return true
        elseif weapon.IsAlwaysLowered or weapon.NeverRaised then
            return false
        end
    end
    return self:getNetVar("raised", false)
end

if SERVER then
    function playerMeta:setWepRaised(state)
        self:setNetVar("raised", state)
        if IsValid(self:GetActiveWeapon()) then
            local weapon = self:GetActiveWeapon()
            weapon:SetNextPrimaryFire(CurTime() + 1)
            weapon:SetNextSecondaryFire(CurTime() + 1)
        end
    end

    function playerMeta:toggleWepRaised()
        timer.Simple(1, function() self:setWepRaised(not self:isWepRaised(), ShouldPrintMessage) end)
        local weapon = self:GetActiveWeapon()
        if IsValid(weapon) then
            if self:isWepRaised() and weapon.OnRaised then
                weapon:OnRaised()
            elseif not self:isWepRaised() and weapon.OnLowered then
                weapon:OnLowered()
            end
        end
    end
end