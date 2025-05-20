function MODULE:Move(client, moveData)
    local wep = client:GetActiveWeapon()
    if not IsValid(wep) then return end
    local baseSpeed = self.WeaponsSpeed[wep:GetClass()]
    if not baseSpeed then return end
    local walkRatio = lia.config.get("WalkRatio")
    local speed = moveData:KeyDown(IN_WALK) and baseSpeed * walkRatio or baseSpeed
    moveData:SetMaxSpeed(speed)
    moveData:SetMaxClientSpeed(speed)
end