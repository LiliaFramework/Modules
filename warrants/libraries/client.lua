function MODULE:DrawCharInfo(client, _, info)
    local character = client:getChar()
    if character and character.IsWanted and character:IsWanted() and LocalPlayer():CanSeeWarrants() then info[#info + 1] = {L("WarrantedText"), Color(255, 0, 0)} end
end

function MODULE:LoadCharInformation()
    hook.Run("AddTextField", L("generalinfo"), "wanted", L("wanted"), function()
        local character = LocalPlayer():getChar()
        if character and character.getWanted and character:getWanted() then return L("wanted") end
        return L("upstanding")
    end)
end

function MODULE:LoadMainMenuInformation(info, character)
    if character:getWanted() then
        table.insert(info, L("reputation") .. ": " .. L("wanted"))
    else
        table.insert(info, L("reputation") .. ": " .. L("upstanding"))
    end
end
