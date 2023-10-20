--------------------------------------------------------------------------------------------------------
function HandcuffPlayer(target)
	target:SetRunSpeed(target:GetWalkSpeed())
	for k, v in pairs(target:getChar():getInv():getItems()) do
		if v.isWeapon and v:getData("equip") then
			v:setData("equip", nil)
		end
	end

	if target.carryWeapons then
		for _, weapon in pairs(target.carryWeapons) do
			target:StripWeapon(weapon:GetClass())
		end

		target.carryWeapons = {}
	end

	timer.Simple(
		.2,
		function()
			target:SelectWeapon("lia_keys")
			target:setNetVar("restricted", true)
		end
	)

	if lia.module.list["anim"] then
		OnHandCuffAnimation(target, 0)
	end
end

--------------------------------------------------------------------------------------------------------
function OnHandcuffRemove(target)
	target:setNetVar("restricted", false)
	target:SetRunSpeed(lia.config.RunSpeed)
	hook.Run("ResetSubModuleCuffData", target)
	SetDrag(target, nil)
	if lia.module.list["anim"] then
		OnHandCuffAnimation(target, 0)
	end
end
--------------------------------------------------------------------------------------------------------