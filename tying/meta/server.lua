local playerMeta = FindMetaTable("Player")
function playerMeta:startHandcuffAnim()
    if not self:LookupBone("ValveBiped.Bip01_L_UpperArm") then return end
    local bones = {
        ["ValveBiped.Bip01_L_UpperArm"] = Angle(20, 8.8, 0),
        ["ValveBiped.Bip01_L_Forearm"] = Angle(15, 0, 0),
        ["ValveBiped.Bip01_L_Hand"] = Angle(0, 0, 75),
        ["ValveBiped.Bip01_R_Forearm"] = Angle(-15, 0, 0),
        ["ValveBiped.Bip01_R_Hand"] = Angle(0, 0, -75),
        ["ValveBiped.Bip01_R_UpperArm"] = Angle(-20, 16.6, 0),
    }

    self:networkAnimation(true, bones)
end

function playerMeta:endHandcuffAnim()
    if not self:LookupBone("ValveBiped.Bip01_L_UpperArm") then return end
    self:networkAnimation(false, {})
end

function MODULE:KeyPress(client, key)
    if client:isHandcuffed() and key == IN_DUCK then
        local bones = {
            ["ValveBiped.Bip01_L_UpperArm"] = Angle(29.4, 43, 0),
            ["ValveBiped.Bip01_L_Forearm"] = Angle(0.9, 85.7, 0),
            ["ValveBiped.Bip01_L_Hand"] = angle_zero,
            ["ValveBiped.Bip01_R_Forearm"] = Angle(0, 80.143, 0),
            ["ValveBiped.Bip01_R_Hand"] = angle_zero,
            ["ValveBiped.Bip01_R_UpperArm"] = Angle(-39.3, 85.4, -30.4),
        }

        client:networkAnimation(true, bones)
    end
end

function MODULE:KeyRelease(client, key)
    if client:isHandcuffed() and key == IN_DUCK then
        local bones = {
            ["ValveBiped.Bip01_L_UpperArm"] = Angle(20, 8.8, 0),
            ["ValveBiped.Bip01_L_Forearm"] = Angle(15, 0, 0),
            ["ValveBiped.Bip01_L_Hand"] = Angle(0, 0, 75),
            ["ValveBiped.Bip01_R_Forearm"] = Angle(-15, 0, 0),
            ["ValveBiped.Bip01_R_Hand"] = Angle(0, 0, -75),
            ["ValveBiped.Bip01_R_UpperArm"] = Angle(-20, 16.6, 0),
        }

        client:networkAnimation(true, bones)
    end
end
