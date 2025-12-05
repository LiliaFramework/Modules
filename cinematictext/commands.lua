lia.command.add("cinematicmenu", {
    adminOnly = true,
    desc = "cinematicMenuDesc",
    onRun = function(client)
        net.Start("OpenCinematicMenu")
        net.Send(client)
    end
})
