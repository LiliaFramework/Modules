lia.command.add("cinematicmenu", {
    privilege = "Use Cinematic Menu",
    adminOnly = true,
    onRun = function(client)
        net.Start("OpenCinematicMenu")
        net.Send(client)
    end
})
