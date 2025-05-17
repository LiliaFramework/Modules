function MODULE:ScalePlayerDamage(client, hitgroup, dmgInfo)
    if lia.config.get("instakilling") and hitgroup == HITGROUP_HEAD then dmgInfo:SetDamage(client:GetMaxHealth() * 5) end
end