
local MODULE = MODULE

MODULE.name = "Rappelling"
MODULE.author = "wowm0d & bloodycop"
MODULE.version = "Stock"
MODULE.desc = "Adds a rappel gear."

function MODULE:StartRappel(client)
	client.rappelling = true
	client.rappelPos = client:GetPos()

	if (SERVER) then
		self:CreateRope(client)
	end
end

function MODULE:EndRappel(client)
	client.rappelling = nil

	if (SERVER) then
		self:RemoveRope(client)
	end
end

function MODULE:CreateRope(client)
	local attachmentIndex

	if (client.ixAnimModelClass == "metrocop") then
		attachmentIndex = client:LookupAttachment("anim_attachment_LH")
	else
		attachmentIndex = client:LookupAttachment("hips")
	end

	local attachment = client:GetAttachment(attachmentIndex)

	if (attachmentIndex == 0 || attachmentIndex == -1) then
		attachment = {Pos = client:GetBonePosition(client:LookupBone("ValveBiped.Bip01_Pelvis"))}
		attachmentIndex = client:LookupAttachment("forward")
	end

	local rappelRope = ents.Create("keyframe_rope")
		rappelRope:SetParent(client, attachmentIndex)
		rappelRope:SetPos(attachment && attachment.Pos || client:GetPos())
		rappelRope:SetColor(Color(150, 150, 150))
		rappelRope:SetEntity("StartEntity", rappelRope)
		rappelRope:SetEntity("EndEntity", Entity(0))
		rappelRope:SetKeyValue("Width", 2)
		rappelRope:SetKeyValue("Collide", 1)
		rappelRope:SetKeyValue("RopeMaterial", "cable/cable")
		rappelRope:SetKeyValue("EndOffset", tostring(client.rappelPos || client:GetPos()))
		rappelRope:SetKeyValue("EndBone", 0)
	client.rappelRope = rappelRope

	client:DeleteOnRemove(rappelRope)
	client:EmitSound("npc/combine_soldier/zipline_clip" .. math.random(2) .. ".wav")

end

function MODULE:RemoveRope(client)
	if (IsValid(client.rappelRope)) then
		client.rappelRope:Remove()
	end

	client.rappelRope = nil
	client.oneTimeRappelSound = nil

	local sequence = client:LookupSequence("rappelloop")

	if (sequence != 1 && client:GetNetVar("forcedSequence") == sequence) then
		client:SetNetVar("forcedSequence", nil)
	end
end
