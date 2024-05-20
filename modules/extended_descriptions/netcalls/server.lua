util.AddNetworkString("OpenDetailedDescriptions")
util.AddNetworkString("SetDetailedDescriptions")
util.AddNetworkString("EditDetailedDescriptions")
net.Receive("EditDetailedDescriptions", function()
    local textEntryURL = net.ReadString()
    local text = net.ReadString()
    local callingClientSteamName = net.ReadString()
    for _, client in pairs(player.GetAll()) do
        if client:SteamName() == callingClientSteamName then
            client:getChar():setData("textDetDescData", text)
            client:getChar():setData("textDetDescDataURL", textEntryURL)
        end
    end
end)
