function MODULE:Move(client, moveData)
    local wep = client:GetActiveWeapon()
    if not IsValid(wep) then return end
    local baseSpeed = self.WeaponsSpeed[wep:GetClass()]
    if not baseSpeed then return end
    local override = hook.Run("OverrideSlowWeaponSpeed", client, wep, baseSpeed)
    if isnumber(override) then baseSpeed = override end
    local walkRatio = lia.config.get("WalkRatio")
    local speed = moveData:KeyDown(IN_WALK) and baseSpeed * walkRatio or baseSpeed
    hook.Run("ApplyWeaponSlowdown", client, wep, moveData, speed)
    moveData:SetMaxSpeed(speed)
    moveData:SetMaxClientSpeed(speed)
    hook.Run("PostApplyWeaponSlowdown", client, wep, moveData, speed)
end