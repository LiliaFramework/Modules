function MODULE:PostPlayerSay(client, chatType, message)
    if self.DetectedChatTypes[chatType] then
        for _, v in pairs(self.NotAllowedWords) do
            if string.find(message, v) then
                message = string.format("ERPER DETECTED: (%s) (%s) ", client:GetCharacter():GetName(), message)
                for _, ply in pairs(player.Iterator()) do
                    if ply:IsAdmin() then ply:PrintMessage(HUD_PRINTTALK, message) end
                end

                break
            end
        end
    end
end