function MODULE:ScalePlayerDamage(client, hitgroup, dmgInfo)
    if lia.config.get("instakilling") and hitgroup == HITGROUP_HEAD then
        hook.Run("PlayerPreInstantKill", client, dmgInfo)
        dmgInfo:SetDamage(client:GetMaxHealth() * 5)
        hook.Run("PlayerInstantKilled", client, dmgInfo)
    end
end