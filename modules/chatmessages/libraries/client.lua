local nextMessageIndex = 1
function MODULE:InitPostEntity()
    timer.Create("MessageTimer", self.ChatMessagesInterval, 0, function()
        local messageData = self.ChatMessages[nextMessageIndex]
        local prefix = self.CommunityName .. " | "
        local text = messageData
        chat.AddText(Color(255, 0, 0), prefix, color_white, text)
        nextMessageIndex = nextMessageIndex % #self.ChatMessages + 1
    end)
end