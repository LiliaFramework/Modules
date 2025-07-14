lia.command.add("cinematicmenu", {
    privilege = "Use Cinematic Menu",
    adminOnly = true,
    desc = L("cinematicMenuDesc"),
    onRun = function(client)
        net.Start("OpenCinematicMenu")
        net.Send(client)
        hook.Run("CinematicMenuOpened", client)
    end
})
