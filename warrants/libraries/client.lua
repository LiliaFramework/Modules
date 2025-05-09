function MODULE:DrawCharInfo(client, _, info)
    local character = client:getChar()
    if character:IsWanted() and LocalPlayer():CanSeeWarrants() then info[#info + 1] = {L("WarrantedText"), Color(255, 0, 0)} end
end

function MODULE:LoadCharInformation()
    local character = LocalPlayer():getChar()
    hook.Run("AddTextField", L("generalinfo"), "wanted", L("wanted"), function() return character:IsWanted() and L("wanted") or L("upstanding") end)
end

function MODULE:LoadMainMenuInformation(info, character)
    if character:getData("wanted", false) then
        table.insert(info, L("reputationField") .. ": " .. L("wanted"))
    else
        table.insert(info, L("reputationField") .. ": " .. L("upstanding"))
    end
end