local MODULE = MODULE
local function shouldUseAltLower()
    return tobool(lia.option.get("hideHandsWhenLowered", false))
end

function MODULE:CalcViewModelView(weapon, viewModel, oldEyePos, oldEyeAngles, eyePos, eyeAngles)
    if LocalPlayer():getNetVar("pipboyOpen", false) then return end
    if hook.Run("ShouldPreventLoweredWeaponView", weapon, viewModel, oldEyePos, oldEyeAngles, eyePos, eyeAngles) then return end
    if not IsValid(weapon) then return end
    local client = LocalPlayer()
    if not IsValid(client) or not client.isWepRaised then return end
    if not lia.module.list["raiseweapons"] then return end
    if not client.isWepRaised then return end
    local target = client:isWepRaised() and 0 or 100
    client.liaRaisedFrac = Lerp(FrameTime() * 2, client.liaRaisedFrac or 0, target)
    local fraction = (client.liaRaisedFrac or 0) / 100
    if fraction <= 0 then return end
    local rotation = weapon.LowerAngles or Angle(30, -30, -25)
    if shouldUseAltLower() and weapon.LowerAngles2 then rotation = weapon.LowerAngles2 end
    local vmAngles = Angle(eyeAngles.p, eyeAngles.y, eyeAngles.r)
    vmAngles:RotateAroundAxis(vmAngles:Up(), rotation.p * fraction)
    vmAngles:RotateAroundAxis(vmAngles:Forward(), rotation.y * fraction)
    vmAngles:RotateAroundAxis(vmAngles:Right(), rotation.r * fraction)
    return eyePos, vmAngles
end
