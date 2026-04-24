local MODULE = MODULE
local KEY_BLACKLIST = bit.bor(IN_ATTACK, IN_ATTACK2)
lia.command.add("toggleraise", {
    desc = "Toggle whether your current weapon is raised.",
    onRun = function(client)
        if not IsValid(client) then return end
        if (client.liaNextToggleRaise or 0) > CurTime() then return end
        client:toggleWepRaised()
        client.liaNextToggleRaise = CurTime() + 0.5
    end
})

function MODULE:StartCommand(client, command)
    if not IsValid(client) or not client.isWepRaised or client:isWepRaised() then return end
    local weapon = client:GetActiveWeapon()
    if IsValid(weapon) and weapon.FireWhenLowered then return end
    command:RemoveKey(KEY_BLACKLIST)
end

function MODULE:CanPlayerThrowPunch(client)
    if client.isWepRaised and not client:isWepRaised() then return false end
end
