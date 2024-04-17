--------------------------------------------------------------------------------------------------------
function MODULE:DrawCharInfo(client, character, info)
    if client:IsWanted() then
        info[#info + 1] = {"Criminal - Wanted by the Reich Government - Dead or Alive", Color(255, 0, 0)}
    end
end

--------------------------------------------------------------------------------------------------------