local GM = GM or GAMEMODE
function MODULE:PlayerCanHearPlayersVoice(listener, speaker)
    if speaker:getChar() and IsHandcuffed(speaker) and IsGagged(speaker) then return false end
end

function MODULE:ResetSubModuleCuffData(target)
    target:setNetVar("blinded", false)
    target:setNetVar("gagged", false)
end
