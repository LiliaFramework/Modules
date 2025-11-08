local damageNumbers = {}
function MODULE:HUDPaint()
    local duration = lia.option.get("damageNumberTime", 2)
    local baseAlpha = lia.option.get("damageNumberAlpha", 125)
    for i = #damageNumbers, 1, -1 do
        local dn = damageNumbers[i]
        local timeLeft = dn.time - CurTime()
        if timeLeft <= 0 then
            hook.Run("DamageNumberExpired", dn.ent, dn.dmg)
            table.remove(damageNumbers, i)
        else
            local alpha = baseAlpha
            if timeLeft < duration then alpha = baseAlpha * timeLeft / duration end
            local scr = dn.pos:ToScreen()
            if scr.visible then
                draw.SimpleTextOutlined(dn.text, lia.config.get("DamageFont", "Montserrat Medium"), scr.x, scr.y - (255 - alpha) / 2, ColorAlpha(dn.color, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, alpha))
            else
                table.remove(damageNumbers, i)
            end
        end
    end
end

net.Receive("expDamageNumbers", function()
    local ent = net.ReadEntity()
    local dmg = net.ReadUInt(32)
    local ply = LocalPlayer()
    if not IsValid(ent) or not IsValid(ply) then return end
    local col = Color(83, 167, 125)
    local pos = ply:GetShootPos() + ply:GetAimVector() * (ent == ply and 10 or ply:GetShootPos():distance(ent:GetPos())) + VectorRand(ent == ply and 0 or 5)
    if ent == ply then col = Color(255, 0, 0) end
    table.insert(damageNumbers, {
        time = CurTime() + lia.option.get("damageNumberTime", 2),
        text = tostring(dmg),
        pos = pos,
        color = col,
        ent = ent,
        dmg = dmg
    })

    hook.Run("DamageNumberAdded", ent, dmg)
end)