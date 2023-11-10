----------------------------------------------------------------------------------------------
local netcalls = {"cmenu", "ApproveSearch", "RequestSearch", "blindfold", "gag_player", "vehicle_usage", "cmenu_tying", "FF", "RequestID", "ApproveID"}
----------------------------------------------------------------------------------------------
for k, v in pairs(netcalls) do
    util.AddNetworkString(v)
end
----------------------------------------------------------------------------------------------
