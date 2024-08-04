net.Receive("announcement_client", function()
    local message = net.ReadString()
    chat.AddText(Color(255, 56, 252), "[Admin Announcement]: ", Color(255, 255, 255), message)
end)