local MODULE = MODULE
local lastActivityTime = CurTime()
local isAFK = false
local function recordActivity()
	lastActivityTime = CurTime()
	if isAFK then
		isAFK = false
		net.Start("liaAFKStatus")
		net.WriteBool(false)
		net.SendToServer()
	end
end

local function checkAFK()
	local timeout = lia.config.get("AFKTimeMinutes", 5) * 60
	local inactive = CurTime() - lastActivityTime
	if inactive >= timeout and not isAFK then
		isAFK = true
		net.Start("liaAFKStatus")
		net.WriteBool(true)
		net.SendToServer()
	elseif inactive < timeout and isAFK then
		isAFK = false
		net.Start("liaAFKStatus")
		net.WriteBool(false)
		net.SendToServer()
	end
end

function MODULE:RestartAFKTimer()
	timer.Remove("lia_client_afk_check")
	timer.Create("lia_client_afk_check", 1, 0, checkAFK)
end

function MODULE:KeyPress()
	recordActivity()
end

function MODULE:PlayerSay()
	recordActivity()
end

function MODULE:StartCommand(_, cmd)
	if cmd:GetButtons() ~= 0 then
		recordActivity()
		return
	end

	if cmd:GetForwardMove() ~= 0 or cmd:GetSideMove() ~= 0 or cmd:GetUpMove() ~= 0 then
		recordActivity()
		return
	end

	local angles = cmd:GetViewAngles()
	if not MODULE.lastAngles then
		MODULE.lastAngles = angles
		return
	end

	if math.abs(angles.yaw - MODULE.lastAngles.yaw) > 0.5 or math.abs(angles.pitch - MODULE.lastAngles.pitch) > 0.5 then recordActivity() end
	MODULE.lastAngles = angles
end

function MODULE:DrawCharInfo(client, _, info)
	if not IsValid(client) then return end
	local clientIsAFK = client:getNetVar("AFK", false)
	if not clientIsAFK then return end
	local since = client:getNetVar("AFKStart", nil)
	local minutes = 0
	if since then minutes = math.max(0, math.floor((os.time() - tonumber(since)) / 60)) end
	info[#info + 1] = {"AFK for " .. tostring(minutes) .. " minute" .. (minutes == 1 and "" or "s"), Color(200, 200, 200)}
end

function MODULE:InitPostEntity()
	recordActivity()
end

timer.Create("lia_client_afk_check", 1, 0, checkAFK)