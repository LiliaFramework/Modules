local function MakeAllGood()
    local ply = LocalPlayer()
    timer.Create("AllGood", 0.01, 50, function()
        local sens = ply.Sens or 0
        local alpha = ply.alpha_value or 0
        local relation = ply.relation or 0
        if sens > 0 then ply.Sens = sens - 2 end
        if alpha > 0 then ply.alpha_value = alpha - 2 end
        if relation > 0 then ply.relation = relation - 0.02 end
    end)
end

function MODULE:HUDPaint()
    if not lia.config.get("DrawPostProcess") then return end
    local ply = LocalPlayer()
    if not ply.Sens then return end
    surface.SetDrawColor(255, 255, 255, ply.Sens / 2)
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    local tab = {
        ["$pp_colour_addr"] = ply.Sens * 0.0025,
        ["$pp_colour_addg"] = ply.Sens * -0.001,
        ["$pp_colour_addb"] = ply.Sens * -0.002,
        ["$pp_colour_brightness"] = ply.Sens * -0.001,
        ["$pp_colour_contrast"] = 1 + ply.relation / 2,
        ["$pp_colour_colour"] = 1 - ply.relation,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    }

    DrawColorModify(tab)
    DrawMotionBlur(0.35, ply.alpha_value / 100, 0)
    DrawMotionBlur(0.35, ply.relation, 0)
end

net.Receive("fucking_stun", function()
    local ply = net.ReadEntity()
    local tims = net.ReadDouble()
    if tims <= 0 then tims = lia.config.get("StunTime") end
    if not IsValid(ply) or not ply:IsPlayer() then return end
    local eff = EffectData()
    eff:SetEntity(ply)
    eff:SetAttachment(1)
    eff:SetStart(ply:GetShootPos())
    eff:SetOrigin(ply:GetShootPos() - Vector(0, 0, 20))
    eff:SetNormal(Vector(0, 0, 1))
    util.Effect("StunstickImpact", eff)
    ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_RANGE_FRENZY, true)
    if ply == LocalPlayer() then
        ply.StunShit = false
        ply.Sens = ply.Sens or 0
        ply.relation = math.Clamp((ply.relation or 0) + 0.33, 0, 1)
        ply.alpha_value = math.Clamp((ply.alpha_value or 0) + 33, 0, 100)
        timer.Remove("AllGood")
        timer.Create("MakeAllGood", 3, 1, MakeAllGood)
    end

    timer.Create("ShittyFuckFuckStun2", 0.33, 3 * tims, function() ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_RANGE_FRENZY, true) end)
    timer.Create("ShittyFuckFuckStun", 0.05, 20 * tims, function()
        if LocalPlayer() == ply then
            ply.StunShit = not ply.StunShit
            local ang = ply:GetAngles()
            if ply.StunShit then
                ply:SetEyeAngles(Angle(0, ang.y + math.random(-10, 10), ang.r))
            else
                ply:SetEyeAngles(Angle(-20, ang.y + math.random(-10, 10), ang.r))
            end
        end
    end)
end)

net.Receive("fucking_stun2", function()
    local ply = net.ReadEntity()
    if ply == LocalPlayer() then
        ply.Sens = 100
        timer.Remove("AllGood")
        timer.Create("MakeAllGood", 3, 1, MakeAllGood)
    end

    timer.Create("ShittyFuckFuckStun2", 0.33, 3 * lia.config.get("StunTime"), function() ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_WALK_ZOMBIE_01, true) end)
end)

local LASER = Material("cable/redlaser")
net.Receive("omglaser", function()
    local ent = net.ReadEntity()
    if IsValid(ent) then ent.Laser = net.ReadBit() end
end)

function MODULE:PostDrawOpaqueRenderables()
    for _, ply in player.Iterator() do
        if ply:Alive() and ply ~= LocalPlayer() then
            local wep = ply:GetActiveWeapon()
            if IsValid(wep) and wep:GetClass() == "weapon_stungun" and wep.Laser then
                local boneIndex = ply:LookupBone("ValveBiped.Bip01_R_Hand") or 0
                local boneMatrix = ply:GetBoneMatrix(boneIndex)
                if boneMatrix then
                    local startPos = boneMatrix:GetTranslation() + ply:EyeAngles():Forward() * 8 + ply:EyeAngles():Right() * -1
                    local maxDist = lia.config.get("MaxDist")
                    local trace = ply:GetEyeTrace()
                    local endPos = trace.HitPos
                    if startPos:Distance(endPos) > maxDist then endPos = ply:GetShootPos() + ply:EyeAngles():Forward() * maxDist end
                    render.SetMaterial(LASER)
                    render.DrawBeam(startPos, endPos, 2, 0, 12.5, Color(255, 0, 0, 255))
                end
            end
        end
    end
end