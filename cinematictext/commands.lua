lia.command.add("cinematicmenu", {
    privilege = "Use Cinematic Menu",
    adminOnly = true,
    desc = "Opens the cinematic menu for camera controls.",
    onRun = function(client)
        net.Start("OpenCinematicMenu")
        net.Send(client)
    end
})
