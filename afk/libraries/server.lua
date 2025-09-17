local function updatePlayerActivity(client)
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	if not IsValid(client) then return end
	client:setNetVar("isAFK", false)
	client:setNetVar("afkTime", CurTime() + lia.config.get("AFKTime", 180))
	client:setNetVar("lastActivity", CurTime())
end

function MODULE:KeyPress(client)
	updatePlayerActivity(client)
end

function MODULE:PlayerButtonDown(client)
	updatePlayerActivity(client)
end

function MODULE:PlayerSay(client)
	updatePlayerActivity(client)
end

function MODULE:PlayerTick(client)
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	if not IsValid(client) then return end
	local velocity = client:GetVelocity()
	local speed = velocity:Length()
	if speed > 10 then updatePlayerActivity(client) end
end

function MODULE:PlayerUse(client)
	updatePlayerActivity(client)
end

function MODULE:PlayerEnteredVehicle(client)
	updatePlayerActivity(client)
end

function MODULE:PlayerLeaveVehicle(client)
	updatePlayerActivity(client)
end

function MODULE:EntityTakeDamage(target)
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	if not IsValid(target) or not target:IsPlayer() then return end
	updatePlayerActivity(target)
end

function MODULE:PlayerCommand(client)
	updatePlayerActivity(client)
end

function MODULE:PlayerReceiveNet(client, netString)
	local importantNets = {"liaCharList", "liaCharCreate", "liaCharDelete", "liaCharSelect", "liaCharLoad", "liaCharSave"}
	for _, net in ipairs(importantNets) do
		if netString == net then
			updatePlayerActivity(client)
			break
		end
	end
end

net.Receive("liaAFKActivity", function(_, client)
	if not IsValid(client) then return end
	updatePlayerActivity(client)
end)

function MODULE:PlayerInitialSpawn(client)
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	client:setNetVar("isAFK", false)
	client:setNetVar("afkTime", CurTime() + lia.config.get("AFKTime", 180))
	client:setNetVar("lastActivity", CurTime())
end

function MODULE:InitializedModules()
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	timer.Create("liaAFKtimer", 1, 0, function()
		for _, client in ipairs(player.GetAll()) do
			if not IsValid(client) then continue end
			local lastActivity = client:getNetVar("lastActivity", 0)
			local currentTime = CurTime()
			if currentTime - lastActivity >= lia.config.get("AFKTime", 180) and not client:getNetVar("isAFK") then
				client:setNetVar("isAFK", true)
				client:setNetVar("afkTime", currentTime)
				print("[AFK] " .. client:Name() .. " is now AFK")
			end
		end
	end)
end

function MODULE:CanPlayerBeTiedUp(_, target)
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	if target:getNetVar("isAFK") then return false, "This player is AFK and cannot be restrained." end
end

function MODULE:CanPlayerBeUntied(_, target)
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	if target:getNetVar("isAFK") then return false, "This player is AFK and cannot be unrestrained." end
end

function MODULE:CanPlayerBeArrested(_, target)
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	if target:getNetVar("isAFK") then return false, "This player is AFK and cannot be arrested." end
end

function MODULE:CanPlayerBeUnarrested(_, target)
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	if target:getNetVar("isAFK") then return false, "This player is AFK and cannot be unarrested." end
end

function MODULE:CanPlayerBeStunned(_, target)
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	if target:getNetVar("isAFK") then return false, "This player is AFK and cannot be stunned." end
end

function MODULE:CanPlayerBeKnockedOut(_, target)
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	if target:getNetVar("isAFK") then return false, "This player is AFK and cannot be knocked out." end
end

concommand.Add("lia_afk_status", function(client)
	if not IsValid(client) then return end
	print("[AFK] Player AFK Status:")
	for _, ply in ipairs(player.GetAll()) do
		if IsValid(ply) then
			local isAFK = ply:getNetVar("isAFK", false)
			local lastActivity = ply:getNetVar("lastActivity", 0)
			local afkTime = ply:getNetVar("afkTime", 0)
			local timeSinceActivity = CurTime() - lastActivity
			local timeAFK = isAFK and (CurTime() - afkTime) or 0
			print(string.format("  %s: %s (Last Activity: %.1fs ago, AFK Time: %.1fs)", ply:Name(), isAFK and "AFK" or "Active", timeSinceActivity, timeAFK))
		end
	end
end)

concommand.Add("lia_afk_toggle", function(client)
	if not IsValid(client) or not client:IsAdmin() then return end
	local currentValue = lia.config.get("AFKProtectionEnabled", true)
	lia.config.set("AFKProtectionEnabled", not currentValue)
	local status = not currentValue and "enabled" or "disabled"
	print("[AFK] AFK Protection " .. status)
end)