function MODULE:DrawCharInfo(client, _, info)
    local character = client:getChar()
    if character:IsWanted() and LocalPlayer():CanSeeWarrants() then info[#info + 1] = {L("WarrantedText"), Color(255, 0, 0)} end
end

function MODULE:LoadCharInformation()
    local character = LocalPlayer():getChar()
    hook.Run("AddTextField", "General Info", "wanted", "Wanted", function() return character:IsWanted() and "Wanted" or "Upstanding" end)
end

function MODULE:LoadMainMenuInformation(info, character)
    if character:IsWanted() then table.insert(info, "Reputation: " .. (character:IsWanted() and "Wanted" or "Outstanding")) end
end