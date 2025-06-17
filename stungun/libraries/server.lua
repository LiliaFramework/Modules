local function DeleteHelpEnt(ply)
    if IsValid(ply) and IsValid(ply.HelpEnt) then ply.HelpEnt:Remove() end
end

hook.Add("PlayerDeath", "diesbitch", DeleteHelpEnt)
hook.Add("PlayerSpawn", "spawnedbitch", DeleteHelpEnt)
hook.Add("PlayerDisconnected", "leavingbitch", DeleteHelpEnt)
local networkStrings = {"fucking_stun", "fucking_stun2", "omglaser",}
for _, netString in ipairs(networkStrings) do
    util.AddNetworkString(netString)
end