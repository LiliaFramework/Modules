function MODULE:PostPlayerSay(client, chatType, message)
    if self.DetectedChatTypes[chatType] then
        for _, v in pairs(self.NotAllowedWords) do
            if string.find(message, v) then
                message = string.format("ERPER DETECTED: (%s) (%s) ", client:getChar():getName(), message)
                for _, ply in pairs(player.GetAll()) do
                    if ply:IsAdmin() then ply:PrintMessage(HUD_PRINTTALK, message) end
                end

                break
            end
        end
    end
end
