local WeaponToggleDelay = 1
lia.command.add( "toggleraise", {
    adminOnly = false,
    desc = "Toggles raising or lowering your weapon.",
    onRun = function( client )
        if ( client.liaNextToggle or 0 ) < CurTime() then
            client:toggleWepRaised()
            client.liaNextToggle = CurTime() + WeaponToggleDelay
        end
    end
} )