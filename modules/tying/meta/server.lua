----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local playerMeta = FindMetaTable("Player")
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function playerMeta:StartHandcuffAnim()
	if not self.getChar or not self:getChar() then return end
	if not self:LookupBone("ValveBiped.Bip01_L_UpperArm") then return end
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(20, 8.8, 0))
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(15, 0, 0))
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_L_Hand"), Angle(0, 0, 75))
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(-15, 0, 0))
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(0, 0, -75))
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(-20, 16.6, 0))
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function playerMeta:EndHandcuffAnim()
	if not self.getChar or not self:getChar() then return end
	if not self:LookupBone("ValveBiped.Bip01_L_UpperArm") then return end
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(0, 0, 0))
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(0, 0, 0))
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_L_Hand"), Angle(0, 0, 0))
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(0, 0, 0))
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(0, 0, 0))
	self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(0, 0, 0))
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------