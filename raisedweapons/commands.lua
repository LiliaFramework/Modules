local WeaponToggleDelay = 1
lia.command.add("toggleraise", {
    adminOnly = false,
    syntax = "",
    desc = L("toggleRaiseDesc"),
    onRun = function(client)
        if (client.liaNextToggle or 0) < CurTime() then
            client:toggleWepRaised()
            client.liaNextToggle = CurTime() + WeaponToggleDelay
        end
    end
})
