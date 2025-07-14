local nextMessageIndex = 1
local CommunityName = "A Lilia Server"
local ChatMessages = {"Thank you for playing!", "If you need staff, send them a message @ message!"}
function MODULE:InitPostEntity()
    local interval = lia.config.get("ChatMessagesInterval", 300)
    timer.Create("MessageTimer", interval, 0, function()
        local messageData = ChatMessages[nextMessageIndex]
        local prefix = CommunityName .. " | "
        local text = messageData
        chat.AddText(Color(255, 0, 0), prefix, color_white, text)
        hook.Run("ChatMessageSent", nextMessageIndex, text)
        nextMessageIndex = nextMessageIndex % #ChatMessages + 1
    end)
end
