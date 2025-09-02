local function markAFK(client, state)
	if not IsValid(client) then return end
	local isAFK = client:getNetVar("AFK", false)
	if state and not isAFK then
		client:setNetVar("AFK", true)
		client:setNetVar("AFKStart", os.time())
	elseif not state and isAFK then
		client:setNetVar("AFK", nil)
		client:setNetVar("AFKStart", nil)
	end
end

net.Receive("liaAFKStatus", function(_, client)
	local isAFK = net.ReadBool()
	markAFK(client, isAFK)
end)

function MODULE:PlayerInitialSpawn(client)
	markAFK(client, false)
end

function MODULE:PlayerDisconnected(client)
	if IsValid(client) then
		client:setNetVar("AFK", nil)
		client:setNetVar("AFKStart", nil)
	end
end