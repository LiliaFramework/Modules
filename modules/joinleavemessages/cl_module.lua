--------------------------------------------------------------------------------------------------------------------------
net.Receive(
    "PlayerJoinedLeftAnnouncement",
    function()
        local message = net.ReadString()
        local isJoining = net.ReadBool()
        if isJoining then
            chat.AddText(Color(0, 255, 0), message)
        else
            chat.AddText(Color(255, 0, 0), message)
        end
    end
)
--------------------------------------------------------------------------------------------------------------------------
