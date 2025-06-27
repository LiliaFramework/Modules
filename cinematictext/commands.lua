lia.command.add("cinematicmenu", {
    privilege = "Use Cinematic Menu",
    adminOnly = true,
    syntax = ""
    desc = L("cinematicMenuDesc"),
    onRun = function(client)
        net.Start("OpenCinematicMenu")
        net.Send(client)
    end
})