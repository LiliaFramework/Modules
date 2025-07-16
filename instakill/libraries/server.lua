function MODULE:ScalePlayerDamage(client, hitgroup, dmgInfo)
    if lia.config.get("instakilling") and hitgroup == HITGROUP_HEAD then
        if hook.Run("ShouldInstantKill", client, dmgInfo) == false then return end

        hook.Run("PlayerPreInstantKill", client, dmgInfo)
        dmgInfo:SetDamage(client:GetMaxHealth() * 5)
        hook.Run("PlayerInstantKilled", client, dmgInfo)
    end
end