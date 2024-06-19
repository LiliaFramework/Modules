lia.command.add("screamerban", {
    privilege = "Use Screamer",
    adminOnly = true,
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        net.Start("screamerban")
        net.Send(target)
        timer.Simple(5, function() if IsValid(target) then target:Ban(0, true) end end)
    end
})
