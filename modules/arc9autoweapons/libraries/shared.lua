local MODULE = MODULE

if (ARC9) then

    if(CLIENT) then
        GetConVar("arc9_hud_arc9"):SetInt(0)
        GetConVar("arc9_cross_enable"):SetInt(0)
    end
    
    function MODULE:PostPlayerLoadout(client)
        client.ARC9_AttInv = {}

        for i,v in pairs(client:getChar():getInv():getItems()) do
            if v.category == "Attachements" then
                ARC9:PlayerGiveAtt(client, v.att)
                ARC9:PlayerSendAttInv(client)
            end
        end
    end

    GrenadeClass = {}
    hook.Add("EntityRemoved", "ARC9RemoveGrenade", function(entity)
        if (GrenadeClass[entity:GetClass()]) then
            local client = entity:GetOwner()
            if (IsValid(client) and client:IsPlayer() and client:GetCharacter()) then
                local ammoName = game.GetAmmoName(entity:GetPrimaryAmmoType())
                if (isstring(ammoName) and client:GetAmmoCount(ammoName) < 1
                and entity.liaItem and entity.liaItem.Unequip) then
                    entity.liaItem:Unequip(client, false, true)
                end
            end
        end
    end)
end

function MODULE:InitializedModules()
    if (!ARC9) then
        return print(" -- [[ ARC9 Compatibility - Cant find ARC9 Addon! ")
    else
        if (SERVER) then
            ARC9.NoHUD = true
            GetConVar("arc9_free_atts"):SetInt(0)
            GetConVar("arc9_atts_lock"):SetInt(0)
        end
        print("-- [[ ARC9 Compatibility - Loading Weapons... ]]--")
        for i,v in pairs(weapons.GetList()) do
			if weapons.IsBasedOn(v.ClassName, "arc9_base") then
				local ITEM = lia.item.register(v.ClassName, "base_weapons", false, nil, true)
				ITEM.name = v.PrintName
				ITEM.description = v.Description or nil
				ITEM.model = v.WorldModel
				ITEM.class = v.ClassName
				ITEM.width = 3
				ITEM.height = 2
				ITEM.category = "Weapons"
				ITEM.weaponCategory = "Primary"
				if (v.Throwable) then
					ITEM.weaponCategory = "Throwable"
					ITEM.width = 1
					ITEM.height = 1
					ITEM.isGrenade = true
					GrenadeClass[v.ClassName] = true
				elseif (v.NotAWeapon) then
					ITEM.width = 1
					ITEM.height = 1
				elseif (v.PrimaryBash) then
					ITEM.weaponCategory = "Melee"
					ITEM.width = 1
					ITEM.height = 2
				elseif (v.HoldType == "pistol" or v.HoldType == "revolver") then
					ITEM.weaponCategory = "Secondary"
					ITEM.width = 2
					ITEM.height = 1
				end
				function ITEM:getDesc()
					return self.description
				end
				print("ARC9 Compatibility - "..v.ClassName.." Loaded!")
			end
        end
        print("-- [[ ARC9 Compatibility - All Weapons Loaded! ]]--")
        print("-- [[ ARC9 Compatibility - Loading Attachments... ]]--")
        for i,v in pairs(ARC9.Attachments) do
            if (!i.Free) then
                local ITEM = lia.item.register(i, nil, false, nil, true)
                ITEM.name = v.PrintName
                ITEM.description = "A weapon attachement."
                ITEM.model = v.Model or "models/items/arc9/att_plastic_box.mdl"
                ITEM.width = 1
                ITEM.height = 1
                ITEM.att = i
                ITEM.category = "Attachements"
                function ITEM:GetDescription()
                    return self.description
                end
                --]]-- TBD CREATED IN INV
                function ITEM:transfer(oldInventory, newInventory)
                    if (oldInventory and isfunction(oldInventory.GetOwner)) then
                        if (IsValid(oldInventory:GetOwner())) then
                            for _,v in pairs(oldInventory:GetOwner():GetWeapons()) do
                                if(v.Attachments) then
                                    for i,s in pairs(v.Attachments) do
                                        if(s.Installed == ITEM.att) then
                                            v:DetachAllFromSubSlot(i, false)
                                            v:SendWeapon()
                                            v:PostModify()
                                            ARC9:PlayerGiveAtt(oldInventory:GetOwner(), ITEM.att)
                                        end
                                    end 
                                end
                            end
                            ARC9:PlayerTakeAtt(oldInventory:GetOwner(), ITEM.att)
                            ARC9:PlayerSendAttInv(oldInventory:GetOwner())
                        end
                    end
        
                    if (newInventory and isfunction(newInventory.GetOwner)) then
                        if (IsValid(newInventory:GetOwner())) then
                            ARC9:PlayerGiveAtt(newInventory:GetOwner(), ITEM.att)
                            ARC9:PlayerSendAttInv(newInventory:GetOwner())
                        end
                    end
                    return true
                end
                print("-- [[ ARC9 Compatibility - "..i.." Loaded! ]]--")
            end
        end
        print("-- [[ ARC9 Compatibility - All Attachments Loaded! ]]--")
    end
    print("-- [[ ARC9 Compatibility - Has finished loading! ]]--")
end