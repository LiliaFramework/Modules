local lastMousePos = {
	x = 0,
	y = 0
}

local lastActivityCheck = 0
local function checkClientActivity()
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	local client = LocalPlayer()
	if not IsValid(client) then return end
	local mouseX, mouseY = gui.MouseX(), gui.MouseY()
	if mouseX ~= lastMousePos.x or mouseY ~= lastMousePos.y then
		lastMousePos.x, lastMousePos.y = mouseX, mouseY
		net.Start("liaAFKActivity")
		net.SendToServer()
	end

	local viewAngles = client:EyeAngles()
	if viewAngles ~= client.lastViewAngles then
		client.lastViewAngles = viewAngles
		net.Start("liaAFKActivity")
		net.SendToServer()
	end
end

function MODULE:Think()
	if CurTime() - lastActivityCheck > 0.5 then
		checkClientActivity()
		lastActivityCheck = CurTime()
	end
end

function MODULE:OnPlayerChat(client)
	if client == LocalPlayer() then
		net.Start("liaAFKActivity")
		net.SendToServer()
	end
end

function MODULE:PlayerBindPress(client, _, pressed)
	if client == LocalPlayer() and pressed then
		net.Start("liaAFKActivity")
		net.SendToServer()
	end
end

function MODULE:DrawCharInfo(client, _, info)
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	if not client:getNetVar("isAFK") then return end
	local afkTime = client:getNetVar("afkTime", 0)
	local timeAFK = CurTime() - afkTime
	info[#info + 1] = {"💤 " .. L("afkForTime", string.NiceTime(timeAFK)), Color(255, 165, 0)}
end

function MODULE:HUDPaintBackground()
	if not lia.config.get("AFKProtectionEnabled", true) then return end
	if not LocalPlayer():getNetVar("isAFK") then return end
	local afkTime = LocalPlayer():getNetVar("afkTime", 0)
	local timeAFK = CurTime() - afkTime
	local width = ScrW() * 0.4
	local height = 60
	local x = (ScrW() - width) * 0.5
	local y = ScrH() * 0.1
	draw.RoundedBox(8, x, y, width, height, Color(0, 0, 0, 150))
	draw.RoundedBox(8, x + 2, y + 2, width - 4, height - 4, Color(255, 165, 0, 50))
	draw.SimpleText("💤 " .. L("youAreAFK"), "liaBigFont", x + width * 0.5, y + 15, Color(255, 165, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(L("time") .. ": " .. string.NiceTime(timeAFK), "liaMediumFont", x + width * 0.5, y + 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end