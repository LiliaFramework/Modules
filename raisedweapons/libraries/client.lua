lia.option.add("useAltLower", "Use Alternate Lowering", "Enable or disable the alternate weapon lowering angles.", false, nil, {
    category = "ViewModel",
    type = "Boolean",
    IsQuick = true
})

function MODULE:CalcViewModelView(weapon, _, _, _, _, eyeAngles)
    if not IsValid(weapon) then return end
    local vm_angles = eyeAngles
    local client = LocalPlayer()
    local value = 0
    if not client:isWepRaised() then value = 100 end
    local fraction = (client.liaRaisedFrac or 0) / 100
    local rotation = weapon.LowerAngles or Angle(30, -30, -25)
    if lia.option.get("useAltLower") and weapon.LowerAngles2 then rotation = weapon.LowerAngles2 end
    vm_angles:RotateAroundAxis(vm_angles:Up(), rotation.p * fraction)
    vm_angles:RotateAroundAxis(vm_angles:Forward(), rotation.y * fraction)
    vm_angles:RotateAroundAxis(vm_angles:Right(), rotation.r * fraction)
    client.liaRaisedFrac = Lerp(FrameTime() * 2, client.liaRaisedFrac or 0, value)
end
