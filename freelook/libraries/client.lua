local freelooking, LookX, LookY, InitialAng, CoolAng, ZeroAngle = false, 0, 0, Angle(), Angle(), Angle()
local function IsInSights(client)
    local weapon = client:GetActiveWeapon()
    return lia.option.get("freelookBlockADS") and (client:KeyDown(IN_ATTACK2) or weapon.GetInSights and weapon:GetInSights() or weapon.ArcCW and weapon:GetState() == ArcCW.STATE_SIGHTS or weapon.GetIronSights and weapon:GetIronSights())
end

local function HoldingBind(client)
    if not input.LookupBinding("freelook") then
        return client:KeyDown(IN_WALK)
    else
        return freelooking
    end
end

function MODULE:CalcView(client, _, angles)
    if not client:getChar() or not lia.option.get("freelookEnabled") then return end
    if lia.gui.character and IsValid(lia.gui.character) then return end
    local smoothness = math.Clamp(lia.option.get("freelookSmoothness"), 0.1, 2)
    CoolAng = LerpAngle(0.15 * smoothness, CoolAng, Angle(LookY, -LookX, 0))
    if not HoldingBind(client) and math.abs(CoolAng.p) < 0.05 or IsInSights(client) and math.abs(CoolAng.p) < 0.05 or not system.HasFocus() or client:ShouldDrawLocalPlayer() then
        InitialAng = angles + CoolAng
        LookX, LookY = 0, 0
        CoolAng = ZeroAngle
        return
    end

    angles.p = angles.p + CoolAng.p
    angles.y = angles.y + CoolAng.y
end

function MODULE:CalcViewModelView(wep, _, _, _, _, ang)
    local lp = LocalPlayer()
    if not lp:getChar() or not lia.option.get("freelookEnabled") then return end
    local MWBased = wep.m_AimModeDeltaVelocity and -1.5 or 1
    ang.p = ang.p + CoolAng.p / 2.5 * MWBased
    ang.y = ang.y + CoolAng.y / 2.5 * MWBased
end

function MODULE:InputMouseApply(cmd, x, y)
    local lp = LocalPlayer()
    if not lp:getChar() or not lia.option.get("freelookEnabled") then return end
    if not HoldingBind(lp) or IsInSights(lp) or lp:ShouldDrawLocalPlayer() then
        LookX, LookY = 0, 0
        return
    end

    InitialAng.z = 0
    cmd:SetViewAngles(InitialAng)
    LookX = math.Clamp(LookX + x * 0.02, -lia.option.get("freelookLimitHorizontal"), lia.option.get("freelookLimitHorizontal"))
    LookY = math.Clamp(LookY + y * 0.02, -lia.option.get("freelookLimitVertical"), lia.option.get("freelookLimitVertical"))
    return true
end

function MODULE:StartCommand(client, cmd)
    if not client:IsPlayer() or not client:Alive() then return end
    if not client:getChar() then return end
    if not lia.option.get("freelookBlockADS") then return end
    if not HoldingBind(client) or IsInSights(client) or client:ShouldDrawLocalPlayer() then return end
    cmd:RemoveKey(IN_ATTACK)
end

function MODULE:SetupQuickMenu(menu)
    menu:addCheck(L("enableFreelookLabel"), function(_, state)
        lia.option.set("freelookEnabled", state)
        if state then
            LocalPlayer():ChatPrint(L("freelookOnMessage"))
        else
            LocalPlayer():ChatPrint(L("freelookOffMessage"))
        end
    end, lia.option.get("freelookEnabled"))
end

concommand.Add("+freelook", function()
    freelooking = true
end)

concommand.Add("-freelook", function()
    freelooking = false
end)
